require 'nokogiri'

module Jekyll
  module Amp
    module Filter
      def ampify(input)
        doc = Nokogiri::HTML.fragment(input)

        ampify_image doc
        ampify_yt doc

        doc.to_s
      end

      private

      def ampify_image(doc)
        doc.css('img').each do |image|
          image.name = 'amp-img'

          image['class']&.sub! 'b-lazy', ''
          image['src'] = image['data-src']
          image['layout'] = 'responsive'
          image.delete 'data-src'

          no_script = Nokogiri::XML::Node.new 'noscript', doc

          no_script_img = image.dup
          no_script_img.remove_attribute('layout')
          no_script_img.name = 'img'

          no_script.add_child(no_script_img)

          image.add_child(no_script)
        end
      end

      def ampify_yt(doc)
        doc.css('div.yt').each do |div|
          div.name = 'amp-youtube'

          div['layout'] = 'responsive'
          div['width'] = 1280
          div['height'] = 720

          add_yt_params(div, %r{embed/.*$}.match(div.children.first.attributes['data-src']))

          div.delete 'class'
          div.children = ''
        end
      end

      def add_yt_params(div, yt_params)
        split_yt_params = yt_params.to_s.split '?'

        div['data-videoid'] = split_yt_params.first.sub 'embed/', ''

        split_yt_params.last.split('&').each do |param|
          split_param = param.split '='
          if split_param.first == 'autoplay'
            div[split_param.first] = split_param.last
          else
            div["data-param-#{split_param.first}"] = split_param.last
          end
        end
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::Amp::Filter)
