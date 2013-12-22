module Docs
  class Pyqt
    class CleanHtmlFilter < Filter
      def call
        extract_module

        # Remove module, etc. from h1
        css('h1').each do |node|
          h1 = Nokogiri::XML::Node.new 'h1', doc
          h1.content = node.content.split.first
          newnode = node.replace(h1)
          pre = Nokogiri::XML::Node.new 'pre', doc
          pre.content = "from PyQt4.#{result[:module]} import #{h1.content}"
          newnode.add_next_sibling(pre)
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
