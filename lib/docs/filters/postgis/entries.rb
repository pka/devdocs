module Docs
  class Postgis
    class EntriesFilter < Docs::EntriesFilter

      def get_name
        # <div class="refentry"><h1 name="ST_Collect">ST_Collect</h1>
        entry = at_css('div.refentry h1')
        if entry
          entry['name']
        else
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
          css('div.sect1 h2,h3').each do |title|
            chapter = title.content.sub(/^[\d.]+ /, '')
            unless chapter == 'Raster Processing' or
                   ['using_postgis_dbmanagement', 'using_raster_dataman', 'address_standardizer'].include?(slug)
              entries << [chapter, title['id'], chapter]
            end
          end
        end
        entries
      end
    end
  end
end
