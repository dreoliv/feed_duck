module FeedDuck
  class AtomFeed
    def initialize(parsed_feed)
      @parsed_feed = parsed_feed
    end

    def title
      parsed_feed.title.content
    end

    def url
      parsed_feed.links.reject { |link| link.rel == "self" }.first.href
    end

    def subtitle
      parsed_feed.subtitle.content
    end

    def entries
      parsed_feed.entries.map { |entry| AtomEntry.new(entry) }
    end

    alias :description :subtitle

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
      [:title, :url, :description, :subtitle]
    end
  end

  class AtomEntry
    def initialize(parsed_entry)
      @parsed_entry = parsed_entry
    end

    def title
      parsed_entry.title.content
    end

    def content
      parsed_entry.content.content
    end

    def published_at
      parsed_entry.updated.content
    end

    def author
      parsed_entry.author.name.content
    end

    def url
      parsed_entry.link.href
    end

    def id
      parsed_entry.id.content
    end

    def to_h
      public_attributes.each_with_object(Hash.new) do |attr, attribute_hash|
        attribute_hash[attr] = send(attr)
      end
    end

    private

    attr_reader :parsed_entry

    def public_attributes
      [:title, :content, :published_at, :author, :url, :id]
    end
  end
end
