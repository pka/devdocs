module Docs
  class Gdal < FileScraper
    self.name = 'GDAL/OGR'
    self.slug = 'gdal'
    self.type = 'gdal'
    self.version = '2.2.0'
    self.dir = '/home/builder/geoapis/docs/gdal'
    #self.base_url = 'http://www.gdal.org'
    self.root_path = 'index.html'
    self.initial_paths = ['python/osgeo-module.html']

    html_filters.push 'gdal/clean_html', 'gdal/entries'

    options[:skip_patterns] = [/_source.html$/, /-members.html$/, /^dir_/, /\.xml$/,
      /.cpp.html$/, /^globals/, /^geopackage_aspatial.html$/,
      /^frmt_mrsid_lidar_view_point_cloud.html$/,
      /^pages.html$/, /^annotated.html$/, /^files.html$/, /^index_ru.html$/, /^index_br.html$/,
      /^credits.html$/, /^download.html$/, /^functions.html$/, /^hierarchy.html$/,
      /^deprecated.html$/, /^gdal_building.html$/, /^usergroup0.html$/, /^unionOGRField.html$/,
      /^python\/identifier-index.html$/, /^python\/module-tree.html$/, /^python\/help.html$/,
      /^python\/frames.html$/, /^python\/.+-pysrc.html$/, /^python\/.+_object-class.html$/]

    options[:attribution] = <<-HTML
      In general GDAL/OGR is licensed under an MIT/X style license. 
      All licenses that apply can be displayed from GDAL commandline utilities 
      using the --license commandline switch. 
    HTML
  end
end
