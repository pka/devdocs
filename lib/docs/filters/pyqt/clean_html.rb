module Docs
  class Pyqt
    class CleanHtmlFilter < Filter
      def call
        extract_module

        css('title').remove
        css('hr').remove

        # Remove module, etc. from h1
        if node = at_css('h1')
          classname = node.content.split.first
          h1 = Nokogiri::XML::Node.new 'h1', doc
          h1.content = classname
          newnode = node.replace(h1)
          inner_class = classname.include?('.')
          unless inner_class
            pre = Nokogiri::XML::Node.new 'pre', doc
            pre.content = "from PyQt4.#{result[:module]} import #{classname}"
            newnode.add_next_sibling(pre)
          end
        end

        css('h2').each do |node|
          if node.content == 'Detailed Description'
            node['id'] = 'details'
          end
        end

        # Set id attributes on <h3> instead of an empty <a>
        css('h3.fn').each do |node|
          node['id'] = node.at_css('a')['name']
        end

        doc
      end

      def extract_module
        if node = at_css('h1 a')
          result[:module] = node.content
        end
      end
    end
  end
end
