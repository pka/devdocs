module Docs
  class Pyqt < FileScraper
    self.name = 'PyQt'
    self.type = 'pyqt'
    self.root_path = 'classes.html'

    html_filters.push 'pyqt/clean_nav', 'pyqt/clean_html', 'pyqt/entries'

    options[:only_patterns] = [/^\/q/]
    options[:skip] = %w(/qml.html /qvariant.html /qsettings.html)

    version '4' do
      self.release = '4.11.4'
      #apt-get install python-qt4-doc
      self.dir = '/usr/share/doc/python-qt4-doc/html'
      self.base_url = 'http://pyqt.sourceforge.net/Docs/PyQt4'
      options[:attribution] = <<-HTML
        Copyright &copy; Riverbank Computing Ltd and Nokia 2012<br>
        PyQt4 is released under the terms of the GNU General Public License.
      HTML
    end

=begin
    version '5' do
      self.release = '5.7'
      #apt-get install pyqt5-doc
      self.dir = '/usr/share/doc/pyqt5-doc/html'
      self.base_url = 'http://pyqt.sourceforge.net/Docs/PyQt5'
    end
=end
  end
end
