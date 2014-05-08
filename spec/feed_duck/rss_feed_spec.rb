require 'rss'
require 'feed_duck/rss_feed'

describe FeedDuck::RSSFeed do
  let(:rss_feed) do
    File.open('spec/fixtures/feed_fixture.rss', 'r') do |rss|
      RSS::Parser.parse(rss)
    end
  end

  subject { described_class.new(rss_feed) }

  describe "#title" do
    it "returns the RSS feed channel title" do
      expect(subject.title).to eq "RubyFlow"
    end
  end

  describe "#url" do
    it "returns the RSS feed channel url" do
      expect(subject.url).to eq "http://www.rubyflow.com/"
    end
  end

  describe "#description" do
    it "returns the RSS feed channel description" do
      expect(subject.description).to eq "Ruby Links"
    end
  end

  describe "#language" do
    it "returns the RSS feed channel language" do
      expect(subject.language).to eq "en-us"
    end
  end

  describe "#entries" do
    it "returns an array with all the RSS feed items" do
      expect(subject.entries.length).to eq 1
    end
  end

  describe "#to_h" do
    it "returns a hash representation of the feed" do
      expect(subject.to_h).to eq({
        title: "RubyFlow",
        url: "http://www.rubyflow.com/",
        description: "Ruby Links",
        entries: [{
          title: "A Guide to Choosing the Best Gems for Your Ruby Project",
          content: "If you need something done in Ruby, a gem for it probably exists.",
          published_at: Time.new(2014, 4, 8, 16, 40, 33, "+02:00"),
          author: "Author",
          url: "http://feedproxy.google.com/~r/Rubyflow/~3/2ynPljVok9U/10851-a-guide-to-choosing-the-best-gems-for-your-ruby-project",
          id: "http://www.rubyflow.com/items/10851-a-guide-to-choosing-the-best-gems-for-your-ruby-project"
        }]
      })
    end
  end
end

describe FeedDuck::RSSEntry do
  let(:rss_feed) do
    File.open('spec/fixtures/feed_fixture.rss', 'r') do |rss|
      RSS::Parser.parse(rss)
    end
  end

  let(:feed) { FeedDuck::RSSFeed.new(rss_feed) }

  subject { feed.entries.first }

  it "has a FeedDuck::Entry type" do
    expect(subject).to be_a FeedDuck::RSSEntry
  end

  describe "#title" do
    it "returns the entry's title" do
      expect(subject.title).to eq "A Guide to Choosing the Best Gems for Your Ruby Project"
    end
  end

  describe "#content" do
    it "returns the entry's content" do
      expect(subject.content).to include "If you need something done in Ruby, a gem for it probably exists."
    end
  end

  describe "#published_at" do
    it "returns the entry's published date" do
      expect(subject.published_at).to eq Time.new(2014, 4, 8, 16, 40, 33, "+02:00")
    end
  end

  describe "#author" do
    it "returns the entry's author name" do
      expect(subject.author).to eq "Author"
    end
  end

  describe "#url" do
    it "returns a URL to the entry" do
      expect(subject.url).to eq "http://feedproxy.google.com/~r/Rubyflow/~3/2ynPljVok9U/10851-a-guide-to-choosing-the-best-gems-for-your-ruby-project"
    end
  end

  describe "#id" do
    it "returns the entry id" do
      expect(subject.id).to eq "http://www.rubyflow.com/items/10851-a-guide-to-choosing-the-best-gems-for-your-ruby-project"
    end
  end

  describe "#to_h" do
    it "returns a hash representation of the entry" do
      expect(subject.to_h).to eq({
        title: "A Guide to Choosing the Best Gems for Your Ruby Project",
        content: "If you need something done in Ruby, a gem for it probably exists.",
        published_at: Time.new(2014, 4, 8, 16, 40, 33, "+02:00"),
        author: "Author",
        url: "http://feedproxy.google.com/~r/Rubyflow/~3/2ynPljVok9U/10851-a-guide-to-choosing-the-best-gems-for-your-ruby-project",
        id: "http://www.rubyflow.com/items/10851-a-guide-to-choosing-the-best-gems-for-your-ruby-project"
      })
    end
  end
end
