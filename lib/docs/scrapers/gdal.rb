module Docs
  class Gdal < FileScraper
    self.name = 'GDAL/OGR'
    self.slug = 'gdal'
    self.type = 'gdal'
    self.version = '2.2.0'
    self.dir = '/home/builder/geoapis/docs/gdal'
    self.root_path = 'index.html'

    html_filters.push 'gdal/clean_html', 'gdal/entries'

    options[:only_patterns] = [/^drv_/, /^frmt_/, /^ogr__/, /^class/]
    options[:skip_patterns] = [/_source.html$/, /-members.html$/]

    options[:attribution] = <<-HTML
      In general GDAL/OGR is licensed under an MIT/X style license. 
      All licenses that apply can be displayed from GDAL commandline utilities 
      using the --license commandline switch. 
    HTML
  end
end
