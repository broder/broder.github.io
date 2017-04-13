module Jekyll
  module Amp
    class Page < Jekyll::Page
      def initialize(site, base, page)
        @site = site
        @base = base
        @dir = 'amp'
        @name = "#{page.id}.html"

        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), 'amp.html')

        self.content = page.content

        self.data = page.data.merge self.data

        self.data['canonical_url'] = page.url
        self.data['amp'] = true
      end
    end
  end
end