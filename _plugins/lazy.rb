module Jekyll
  module Tags
    class Lazy < Liquid::Tag
      class << self
        def tag_name
          name.split("::").last(2).join('_').downcase
        end
      end

      def initialize(tag_name, input, tokens)
        super

        @input = input
      end

      def attrs_to_html(attrs)
        attrs.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')
      end

      class Image < Lazy
        def render(context)
          attrs = parse_attrs @input, context
          attrs[:src] = context.registers[:site].config['placeholder_image']
          "<img #{attrs_to_html attrs}/>"
        end

        private

        def parse_attrs(input, context)
          split_input = input.split
          attrs = {}
          src = split_input.shift
          attrs[:'data-src'] = context[src] || src
          attrs[:class] = split_input.join ' ' if split_input.any?
          attrs
        end
      end

      class YouTube < Lazy
        def render(context)
          split_input = @input.split

          iframe_attrs = {}
          yt_id = split_input.shift
          iframe_attrs[:'data-src'] = "https://www.youtube.com/embed/#{yt_id}?controls=0&showinfo=0&rel=0&autoplay=1"
          iframe_attrs[:frameborder] = '0'

          div_attrs = {}
          div_attrs[:class] = split_input.any? ? "yt #{split_input.join ' '}" : 'yt'

          "<div #{attrs_to_html div_attrs}><iframe #{attrs_to_html iframe_attrs}></iframe></div>"
        end
      end
    end
  end
end

Liquid::Template.register_tag(Jekyll::Tags::Lazy::Image.tag_name, Jekyll::Tags::Lazy::Image)
Liquid::Template.register_tag(Jekyll::Tags::Lazy::YouTube.tag_name, Jekyll::Tags::Lazy::YouTube)
