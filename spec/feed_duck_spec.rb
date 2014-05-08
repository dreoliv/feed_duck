require 'feed_duck'

describe FeedDuck::Parser do
  describe "#parse" do
    it "parses and returns a RSS feed" do
      feed = File.open('spec/fixtures/feed_fixture.rss', 'r') do |rss|
        FeedDuck::Parser.new(rss).parse
      end

      expect(feed.title).to eq "RubyFlow"
    end

    it "parses and returns an Atom feed" do
      feed = File.open('spec/fixtures/feed_fixture.atom', 'r') do |rss|
        FeedDuck::Parser.new(rss).parse
      end

      expect(feed.title).to eq "Example Feed"
    end
  end

  describe ".parse" do
    it "provides a shortcut for FeedDuck::Parser.new(feed).parse" do
      feed = File.open('spec/fixtures/feed_fixture.rss', 'r') do |rss|
        FeedDuck::Parser.parse(rss)
      end

      expect(feed.title).to eq "RubyFlow"
    end
  end
end
