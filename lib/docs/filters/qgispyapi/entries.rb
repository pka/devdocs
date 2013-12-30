module Docs
  class Qgispyapi
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        at_css('h1')['id']
      end

      def get_type
        name
      end

      def additional_entries
        return [] if root_page?
        entries = []
        css('h3').each do |node|
          entries << [node['id'], node['id']]
        end
        entries
      end
    end
  end
end
