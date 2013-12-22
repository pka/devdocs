module Docs
  class Pyqt
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        at_css('h1').content
      end

      def get_type
        result[:module]
      end

      def additional_entries
        return [] if root_page?
        entries = []
        css('h3.fn').each do |node|
          a = node.at_css('a')
          #Remove return type and arguments
          method = node.content.gsub(/^[\w-]* /, '').gsub(/^\(.+\) /, '').gsub(/ \(.+$/, '')
          entries << [method, a['name']]
        end
        entries
      end
    end
  end
end
