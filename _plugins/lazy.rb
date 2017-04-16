require 'fastimage'

module Jekyll
  module Tags
    class Lazy < Liquid::Tag
      class << self
        def tag_name
          name.split('::').last(2).join('_').downcase
        end
      end

      def initialize(tag_name, markup, tokens)
        super

        @options = parse_options markup.strip
      end

      def attrs_to_html(attrs)
        attrs.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')
      end

      private

      def parse_options(markup)
        opts = {}
        markup.split(',').each do |opt|
          split = opt.split ': '
          opts[split.first.strip.to_sym] = split.last.strip
        end
        opts
      end

      class Image < Lazy
        def render(context)
          attrs = {
            :'data-src' => context[@options[:src]] || @options[:src],
            src: context.registers[:site].config['placeholder_image'],
            alt: context[@options[:alt]] || @options[:alt]
          }

          src = if attrs[:'data-src'].start_with? 'http'
                  attrs[:'data-src']
                else
                  File.join(Dir.pwd, attrs[:'data-src'])
                end

          begin
            size = FastImage.size(src)
            attrs[:width] = size[0]
            attrs[:height] = size[1]
          rescue StandardError => _
            puts "Unable to get image dimensions for '#{src}'."
          end

          attrs[:class] = @options[:class] if @options[:class]
          "<img #{attrs_to_html attrs}/>"
        end
      end

      class YouTube < Lazy
        def render(context)
          iframe_attrs = {
            :'data-src' => "https://www.youtube.com/embed/#{@options[:id]}?controls=0&showinfo=0&rel=0&autoplay=1",
            title: context[@options[:title]] || @options[:title],
            frameborder: '0'
          }

          div_attrs = {
            class: @options[:class] ? "yt #{@options[:class]}" : 'yt'
          }

          "<div #{attrs_to_html div_attrs}><iframe #{attrs_to_html iframe_attrs}></iframe></div>"
        end
      end
    end
  end
end

Liquid::Template.register_tag(Jekyll::Tags::Lazy::Image.tag_name, Jekyll::Tags::Lazy::Image)
Liquid::Template.register_tag(Jekyll::Tags::Lazy::YouTube.tag_name, Jekyll::Tags::Lazy::YouTube)
