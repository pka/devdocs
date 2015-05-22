module Docs
  class Pyqt < FileScraper
    self.name = 'PyQt'
    self.type = 'pyqt'
    self.version = '4.10.14'
    #apt-get install python-qt4-doc
    self.dir = '/usr/share/doc/python-qt4-doc/html'
    self.base_url = 'http://pyqt.sourceforge.net/Docs/PyQt4'
    self.root_path = 'classes.html'

    html_filters.push 'pyqt/clean_nav', 'pyqt/clean_html', 'pyqt/entries'

    options[:only_patterns] = [/^\/q/]
    options[:skip] = %w(/qml.html /qvariant.html /qsettings.html)

    options[:attribution] = <<-HTML
      Copyright &copy; Riverbank Computing Ltd and Nokia 2012<br>
      PyQt4 is released under the terms of the GNU General Public License.
    HTML
  end
end
