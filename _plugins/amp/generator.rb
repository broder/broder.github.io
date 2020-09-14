module Jekyll
  module Amp
    class Generator < Jekyll::Generator
      priority :low

      def generate(site)
        site.posts.docs.each do |post|
          site.pages << Page.new(site, site.source, File.join('amp', post.id), post)
        end
      end
    end
  end
end
