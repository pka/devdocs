module Docs
  class Qgispyapi < FileScraper
    self.name = 'QGIS Python API'
    self.slug = 'qgispyapi'
    self.type = 'qgispyapi'
    self.version = '2.8'
    self.dir = '/home/builder/geoapis/docs/qgispyapi'
    self.root_path = 'classes.html'

    html_filters.push 'qgispyapi/entries'
    options[:fix_urls] = ->(url) do
      pyqturl = url.sub(%r{^http://pyqt.sourceforge.net/Docs/PyQt4/([\w-]+).html}, '/pyqt/\1')
      if pyqturl != url then pyqturl else nil end
    end

    options[:skip] = []

    options[:attribution] = <<-HTML
      QGIS is released under the terms of the GNU General Public License.
    HTML

=begin
    version '2' do
      self.release = '2.8'
      self.dir = '/home/builder/geoapis/docs/qgispyapi'
      options[:fix_urls] = ->(url) do
        pyqturl = url.sub(%r{^http://pyqt.sourceforge.net/Docs/PyQt4/([\w-]+).html}, '/pyqt~4/\1')
        if pyqturl != url then pyqturl else nil end
      end
    end
=end
  end
end
