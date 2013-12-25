module Docs
  class Postgis < FileScraper
    self.name = 'PostGIS'
    self.type = 'postgis'
    self.version = '2.1.1'
    self.dir = '/home/pi/code/rails/devdocs/postgis'
    #recode LATIN1..UTF-8 /home/pi/code/rails/devdocs/postgis/*.html
    self.base_url = 'http://postgis.net/docs/manual-2.1'
    self.root_path = 'index.html'

    html_filters.push 'postgis/clean_nav', 'postgis/clean_html', 'postgis/entries'

    options[:skip] = %w(
      /postgis_introduction.html
      /postgis_installation.html
      /PostGIS_FAQ.html
      /using_postgis_dbmanagement.html
      /using_raster_dataman.html
      /ch06.html
      /performance_tips.html
      /RT_FAQ.html
      /Extras.html
      /PostGIS_Special_Functions_Index.html
      /ch14.html
      /release_notes.html)

    options[:attribution] = <<-HTML
      PostGIS Manual by <a href="http://postgis.net">PostGIS Project</a><br>
      Licensed under a Creative Commons Attribution-Share Alike 3.0 License.
    HTML
  end
end
