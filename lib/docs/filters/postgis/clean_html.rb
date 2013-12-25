module Docs
  class Postgis
    class CleanHtmlFilter < Filter
      def call
        # Set id attributes on <h2> instead of an empty <a>
        css('h2.title').each do |node|
          node['id'] = node.at_css('a')['name']
        end
        #Remove TOC of chapters
        css('div.toc').each do |node|
          if title = node.at_css('p > b')
            node.remove if title.content == 'Table of Contents'
          else
            node.remove if node.parent['title'] =~ /Raster Processing/
          end
        end
        doc
      end
    end
  end
end
