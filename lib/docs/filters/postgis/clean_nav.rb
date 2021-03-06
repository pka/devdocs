module Docs
  class Postgis
    class CleanNavFilter < Filter
      def call
        extract_chapter
        css('div.navheader').remove
        css('div.navfooter').remove
        doc
      end

      def extract_chapter
        if node = at_css('div.navheader th[width="60%"]')
          result[:chapter] = node.content.sub(/^[\d.]+ /, '')
        end
        if node = at_css('a[accesskey="u"]')
          result[:linkup] = node['href']
        end
      end
    end
  end
end
