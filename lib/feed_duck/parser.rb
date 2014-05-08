module FeedDuck
  class Parser
    attr_reader :feed

    def initialize(feed)
      @feed = feed
    end

    def self.parse(feed)
      new(feed).parse
    end

    def parse
      parsed_feed = RSS::Parser.parse(feed)
      map_feed(parsed_feed)
    end

    private

    def map_feed(parsed_feed)
      if parsed_feed.is_a?(RSS::Rss)
        RSSFeed.new(parsed_feed)
      else
        AtomFeed.new(parsed_feed)
      end
    end
  end
end
