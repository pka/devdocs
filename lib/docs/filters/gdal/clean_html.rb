module Docs
  class Gdal
    class CleanHtmlFilter < Filter
      def call
        # Doxygen header
        css('div#top').remove
        css('div.summary').remove
        css('span.mlabels').remove
        # Doxygen footer
        css('hr').each do |node|
          if nnode = node.next
            if nnode.content =~ /^ Generated for GDAL/
                nnode.next.next.remove
                nnode.next.remove
                nnode.remove
            end
          end
          node.remove
        end

        # Doxygen titles
        css('div.title').each do |node|
          node.name = 'h1'
          node.content = node.content.sub(/ File Reference$/, '')
          node.content = node.content.sub(/ Class Reference$/, '')
        end

        # Replace member table with div
        css('table.mlabels, table.memname').each do |node|
          memname = node.content.strip()
          memname.gsub!(/^const /, '')
          memname.gsub!(/^virtual /, '')
          memname.gsub!(/^enum /, '')
          if memname =~ /^#define/
            memname.gsub!(/#define (\w+).*/, '\1')
          elsif memname =~ /^\w+::\w+/
            memname.gsub!(/(^\w+::\w+).+/, '\1')
          else
            memname.gsub!(/.+? ([A-Zw].+?) .*/, '\1')
          end
          div = Nokogiri::XML::Node.new 'div', doc
          div['class'] = 'member'
          div['id'] = memname
          div.content = node.content
          node.parent.add_next_sibling(div)

          node.remove
        end

        doc
      end
    end
  end
end
