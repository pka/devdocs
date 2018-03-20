module Docs
  class Gdal
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        if node = at_css('h1')
          node.content
        else
          slug
        end
      end

      def get_type
        case slug
        when /^drv_/
          'OGR Format'
        when /^frmt_/
          'GDAL Format'
        when /^ogr__/
          'OGR C API'
        when /^classOGR/
          'OGR C++ API_'
        when /^classGDAL/
          'GDAL C++ API'
        end
      end

      def additional_entries
        return [] if root_page?
        entries = []
        css('div.member').each do |node|
          method = node['id']
          entries << [method, method]
        end
        entries
      end

    end
  end
end
