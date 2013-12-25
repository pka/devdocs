module Docs
  class Postgis
    class EntriesFilter < Docs::EntriesFilter

      def get_name
        entry = at_css('div[class="refentry"]')
        if entry
          entry['title']
        else
          #We add h2 subchapters as content
          nil
        end
      end

      def include_default_entry?
        !name.nil?
      end

      def get_type
        result[:chapter]
      end

      def additional_entries
        return [] if root_page?
        entries = []
        if name.nil?
          css('div[class="sect1"] h2').each do |title|
            chapter = title.content.sub(/^[\d.]+ /, '')
            unless chapter == 'Raster Processing'
              entries << ['Content', title['id'], chapter]
            end
          end
        end
        entries
      end
    end
  end
end
