module Docs
  class Postgis
    class CleanHtmlFilter < Filter
      def call
        #Remove head content
        css('meta').remove
        css('link').remove

        #Convert refentry link to h1
        # <div class="refentry"><a name="ST_SRID" id="ST_SRID"></a>
        css('div.refentry > a').each do |node|
          node.name = 'h1'
          node.content = node['name']
        end
        css('div.chapter > div > div > div > h2').remove

        # Remove title 'Name' and append chapter link
        # <div class="refnamediv"><h2>Name</h2>
        css('div.refnamediv > h2').each do |node|
          if node.content == 'Name' && descr = node.parent.at_css('> p')
            descr.content = descr.content.sub(/^\w+ — /, '')

            chapterref = Nokogiri::XML::Node.new 'div', doc
            chapterref['class'] = 'chapterref'
            link = Nokogiri::XML::Node.new 'a', doc
            link['href'] = result[:linkup]
            link.content = result[:chapter]
            chapterref.add_child(link)
            node.parent.add_next_sibling(chapterref)

            node.remove
          end
        end

        # Set id attributes on <h2> instead of an empty <a>
        css('h2.title,h3.title').each do |node|
          node['id'] = node.at_css('a')['name']
        end
        #Remove TOC of chapters
        css('div.toc').each do |node|
          if title = node.at_css('p > b')
            node.remove if title.content == 'Table of Contents'
          else
            node.remove if node.parent['title'] =~ /Raster Processing/
          end
        end
        doc
      end
    end
  end
end
