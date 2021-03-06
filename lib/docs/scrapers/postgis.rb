module Docs
  class Postgis < FileScraper
    self.name = 'PostGIS'
    self.type = 'postgis'
    self.version = '2.4.3'
    self.dir = '/home/builder/geoapis/docs/postgis'
    self.base_url = 'http://postgis.net/docs/manual-2.4'
    self.root_path = 'index.html'

    html_filters.push 'postgis/clean_nav', 'postgis/clean_html', 'postgis/entries'

    options[:skip] = %w(
      /postgis_introduction.html
      /postgis_installation.html
      /PostGIS_FAQ.html
      /ch06.html
      /performance_tips.html
      /RT_FAQ.html
      /PostGIS_Special_Functions_Index.html
      /ch15.html
      /release_notes.html)

    options[:attribution] = <<-HTML
      PostGIS Manual by <a href="http://postgis.net">PostGIS Project</a><br>
      Licensed under a Creative Commons Attribution-Share Alike 3.0 License.
    HTML
  end
end
