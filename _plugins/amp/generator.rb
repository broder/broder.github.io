require 'thread'
require 'thwait'

module Jekyll
  module Amp
    class Generator < Jekyll::Generator
      priority :low

      def generate(site)
        thread_count = 4
        queue = Queue.new
        threads = []

        site.posts.docs.each { |post| queue << post }

        thread_count.times do
          threads << Thread.new do
            until queue.empty?
              post = queue.pop(true) rescue nil
              site.pages << Page.new(site, site.source, post) if post
            end
          end
        end
      end
    end
  end
end
