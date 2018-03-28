module Docs
  class Gdal
    class CleanHtmlFilter < Filter
      def call
        # Doxygen header
        css('div#top').remove
        css('div.summary').remove
        css('span.mlabels').remove

        # epydoc header+footer
        css('table.navbar').each do |node|
          node.next.next.remove
          node.remove
        end
        css('script', 'style', 'link').remove
        # epydoc source links
        css('span.codelink').remove
        # epydoc UML diagrams
        css('center > center > map').remove

        # Doxygen footer
        css('hr').each do |node|
          if nnode = node.next
            if nnode.content =~ /^The documentation for this/
                nnode.next.next.remove
                nnode.next.remove
                nnode.remove
            elsif nnode.content =~ /^ Generated for GDAL/
                nnode.next.next.remove
                nnode.next.remove
                nnode.remove
            end
          end
          node.remove
        end

        # Remove src link + inheritance diag.
        css('div.dynheader').remove
        css('div.dyncontent').remove
        css('a[@href="#details"]').each do |node|
          node.parent.next.next.remove # "Go to the source code of this file."
        end

        # Doxygen titles
        css('div.title').each do |node|
          node.name = 'h1'
          node.content = node.content.sub(/ File Reference$/, '')
          node.content = node.content.sub(/ Class Reference$/, '')
        end

        # Extract h2 from doxygen table
        css('table.memberdecls').each do |node|
          if h2 = node.at_css('h2')
            node.add_previous_sibling(h2)
            node.at_css('tr').remove
          end
        end

        # Extract title from epydoc tables
        css('table.summary,table.details').each do |node|
          if titlenode = node.at_css('span.table-header')
            titlenode.name = 'h2'
            node.add_previous_sibling(titlenode)
            node.at_css('tr.table-header').remove
          end
          node['border'] = '0'
        end

        # Extract embedded table in epydoc summary
        css('td.summary').each do |node|
          if (table = node.children[1]) && (table.name == 'table')
            if td = table.at_css('td')
              td.name = 'div'
              table.add_previous_sibling(td)
              table.remove
            end
          end
        end

        # Extract embedded table in epydoc details
        css('table.details table').each do |node|
          if h3 = node.at_css('h3.epydoc')
            h3.name = 'div'
            if id = node.at_css('span.sig-name')
              h3['id'] = id.text
            end
            node.add_previous_sibling(h3)
            node.remove
          end
        end
        css('table.details').each do |node|
          if h3 = node.at_css('h3.epydoc')
            h3.name = 'div'
            h3['id'] = h3.text
            node.add_previous_sibling(h3)
            if table = node.at_css('table')
              if td = table.at_css('td')
                td.name = 'div'
                table.add_previous_sibling(td)
                table.remove
              end
            end
         end
        end

        # Remove separator rows
        css('td.memSeparator').each do |node|
          node.parent.remove
        end


        # Move anchors
        css("a[@name='details']").each do |node|
          if nnode = node.next
            nnode['id'] = 'details'
          end
        end
        css('.anchor').each do |node|
          if node.next && nnode = node.next.next
            nnode['id'] = node['id']
          end
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
          elsif memname =~ /\w+::\w+$/
            memname.gsub!(/.+ (\w+::\w+)$/, '\1')
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
