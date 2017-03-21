module Jekyll
  module Tags
    class Icon < Liquid::Tag
      class << self
        def tag_name
          name.split('::').last.downcase
        end
      end

      def initialize(tag_name, icon, tokens)
        super

        @icon = icon.strip
      end

      def render(context)
        "<i class=\"fa fa-fw fa-lg #{@icon}\" aria-hidden=\"true\"></i>"
      end
    end
  end
end

Liquid::Template.register_tag(Jekyll::Tags::Icon.tag_name, Jekyll::Tags::Icon)
