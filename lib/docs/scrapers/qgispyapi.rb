module Docs
  class Qgispyapi < FileScraper
    self.name = 'QGIS Python API'
    self.slug = 'qgispyapi'
    self.type = 'qgispyapi'
    self.version = '2.0.1'
    self.dir = '/home/pi/code/gis/geoapis/docs/qgispyapi'
    self.root_path = 'classes.html'

    html_filters.push 'qgispyapi/entries'
    options[:fix_urls] = ->(url) do
      pyqturl = url.sub(%r{^http://pyqt.sourceforge.net/Docs/PyQt4/(\w+).html}, '/pyqt/\1')
      if pyqturl != url then pyqturl else nil end
    end

    options[:skip] = []

    options[:attribution] = <<-HTML
      Copyright &copy; ...<br>
      QGIS is released under the terms of the GNU General Public License.
    HTML
  end
end
