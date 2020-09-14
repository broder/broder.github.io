module Jekyll
  module Amp
    class Page < Jekyll::Page
      # rubocop:disable Lint/MissingSuper
      def initialize(site, base, dir, post)
        # rubocop:enable Lint/MissingSuper
        @site = site
        @base = base
        @dir = dir
        @url = dir
        @name = 'index.html'

        process(@name)
        read_yaml(File.join(base, '_layouts'), 'amp.html')
        generate_content(post)
      end

      def generate_content(post)
        self.content = post.content
        data['body'] = (Liquid::Template.parse post.content).render @site.site_payload

        self.data = post.data.merge data

        data.delete('excerpt')
        data.delete('permalink')

        data['canonical_url'] = post.url
        data['amp'] = true
      end
    end
  end
end
