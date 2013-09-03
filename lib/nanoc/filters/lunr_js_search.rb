require 'nanoc'
require 'json'
require 'nokogiri'

module Nanoc::Filters
  class LunrJsSearchIndexer < Nanoc::Filter

    identifier :lunr_js_search_index
    type :text

    def initialize(hash = {})
      super

      @search_file = File.join(@site.config[:output_dir],
        @site.config[:lunr_js_search_file] || 'search.json')
    end

    def run(content, args = {})
      html = Nokogiri::HTML(content)
      url = assigns[:item_rep].path
      first_image = html.xpath('//img/@src').to_a[0]
      document = {
        :title => extract_text(html, '//article//*[self::h1 or self::h2]/text()'),
        :subtitle => extract_text(html, '//article//*[self::h1 or self::h2]/small//text()'),
        :body => extract_text(html, '//article//*/text()'),
        :img => (first_image.nil?) ? '' : first_image.value(),
        :alt => extract_values(html, '//article//img/@alt')
      }

      if File.exist?(@search_file)
        documents = JSON.parse(File.read(@search_file))
      else
        documents = {}
      end

      documents[url] = document

      File.open(@search_file, 'w') do |file|
        file.write(JSON.pretty_generate(documents))
      end

      content
    end

    def extract_text(html, path)
      tokens = html.xpath(path).to_a.map { |t|
        t.content.gsub('\r', ' ').gsub('\n', ' ').squeeze(' ').strip
      }.reject! { |t|
        t.empty?
      }

      (tokens || []).join(' ')
    end

    def extract_values(html, path)
      tokens = html.xpath(path).to_a.map { |t|
        t.value().gsub('\r', ' ').gsub('\n', ' ').squeeze(' ').strip
      }

      (tokens || []).join(' ')
    end
  end
end