module FeedDuck
  class RSSFeed
    def initialize(parsed_feed)
      @parsed_feed = parsed_feed
    end

    def title
      parsed_feed.channel.title
    end

    def url
      parsed_feed.channel.link
    end

    def description
      parsed_feed.channel.description
    end

    def language
      parsed_feed.channel.language
    end

    def entries
      parsed_feed.items.map do |item|
        RSSEntry.new(item)
      end
    end

    def to_h
      attributes_hash.merge(entries: entries.map(&:to_h))
    end

    private

    attr_reader :parsed_feed

    def attributes_hash
      public_attributes.each_with_object(Hash.new) do |attr, attribute_hash|
        attribute_hash[attr] = send(attr)
      end
    end

    def public_attributes
      [:title, :url, :description]
    end
  end

  class RSSEntry
    def initialize(parsed_feed_entry)
      @parsed_feed_entry = parsed_feed_entry
    end

    def title
      parsed_feed_entry.title
    end

    def content
      parsed_feed_entry.description
    end

    def published_at
      parsed_feed_entry.pubDate
    end

    def author
      parsed_feed_entry.author
    end

    def url
      parsed_feed_entry.link
    end

    def id
      parsed_feed_entry.guid.content
    end

    def to_h
      public_attributes.each_with_object(Hash.new) do |attr, attribute_hash|
        attribute_hash[attr] = send(attr)
      end
    end

    private

    attr_reader :parsed_feed_entry

    def public_attributes
      [:title, :content, :published_at, :author, :url, :id]
    end
  end
end
