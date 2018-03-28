module Docs
  class Gdal
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        if node = at_css('h1')
          if slug =~ /^python/
            # Remove "Class" or "Module"
            node.content.sub(/^\w+/, '')
          else
            node.content
          end
        else
          slug
        end
      end

      def get_type
        case slug
        when /^frmt_/, 'formats_list'
          'GDAL Formats'
        when /^drv_/, 'ogr_formats'
          'OGR Formats'
        when /^gdal.*8h$/, /^cpl__.*8h$/
          'GDAL C API'
        when /^ogr__/, /^ogrsf__/
          'OGR C API'
        when /^classGDAL/, /^structGDAL/, /^classGNM/, /^classCPL/, /^structCPL/, /^classVSI/
          'GDAL C++ API_' # Without trailing character, the webapp displays 'OGR C API' entries in the tree
        when /^classOGR/, /^classIOGR/
          'OGR C++ API_'
        when /gdal_.*tut$/, /tutorial$/, 'warptut', 'gdal_datamodel', 'ogr_arch', 'ogr_apitut', 'ogr_drivertut', 'gnm_arch', 'gnm_tut'
          'Tutorials'
        when /^gdal/, 'pct2rgb', 'rgb2pct', 'nearblack'
          'GDAL Tools'
        when /^ogr/
          'OGR Tools'
        when /^gnm/
          'GNM Tools'
        when /^python\/osgeo\.ogr/
          'OGR Python API'
        when /^python/
          'GDAL Python API'
        else
          slug
        end
      end

      def additional_entries
        return [] if root_page?
        entries = []
        css('div.member').each do |node|
          method = node['id']
          entries << [method, method]
        end
        css('div.epydoc').each do |node|
          if method = node['id']
            classname = at_css('h1').text.sub(/^\w+/, '')
            entries << ["#{classname}.#{method}", method]
          end
        end
        entries
      end

    end
  end
end
