module Jekyll
  module Amp
    class Page < Jekyll::Page
      def initialize(site, base, page)
        @site = site
        @base = base
        @dir = 'amp'
        @name = "#{page.id}.html"

        process(@name)
        read_yaml(File.join(base, '_layouts'), 'amp.html')

        self.content = page.content

        self.data = page.data.merge data

        data['canonical_url'] = page.url
        data['amp'] = true
      end
    end
  end
end
