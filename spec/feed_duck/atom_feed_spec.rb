require 'rss'
require 'feed_duck/atom_feed'

describe FeedDuck::AtomFeed do
  let(:atom_feed) do
    File.open('spec/fixtures/feed_fixture.atom', 'r') do |rss|
      RSS::Parser.parse(rss)
    end
  end

  subject { described_class.new(atom_feed) }

  describe "#title" do
    it "returns the feed title" do
      expect(subject.title).to eq "Example Feed"
    end
  end

  describe "#url" do
    it "returns the feed's url" do
      expect(subject.url).to eq "http://example.org/"
    end
  end

  describe "#subtitle" do
    it "returns the feed's subtitle" do
      expect(subject.subtitle).to eq "A subtitle."
    end
  end

  describe "#description" do
    it "returns the feed's subtitle" do
      expect(subject.description).to eq "A subtitle."
    end
  end

  describe "#entries" do
    it "return an array with the feed entries" do
      expect(subject.entries.count).to eq 1
    end

    it "return instances of FeedDuck::AtomEntry" do
      expect(subject.entries.first). to be_a FeedDuck::AtomEntry
    end
  end

  describe "#to_h" do
    it "returns a hash representation of the feed" do
      expect(subject.to_h).to eq ({
        title: "Example Feed",
        url: "http://example.org/",
        subtitle: "A subtitle.",
        description: "A subtitle.",
        entries: [{
          title: "Atom-Powered Robots Run Amok",
          content: "Some interesting content.",
          published_at: Time.utc(2003, 12, 13, 18, 30, 02),
          author: "John Doe",
          url: "http://example.org/2003/12/13/atom03",
          uuid: "urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a"
        }],
      })
    end
  end
end

describe FeedDuck::AtomEntry do
  let(:atom_feed) do
    File.open('spec/fixtures/feed_fixture.atom', 'r') do |rss|
      RSS::Parser.parse(rss)
    end
  end

  let(:feed) { FeedDuck::AtomFeed.new(atom_feed) }

  subject { feed.entries.first }

  it "has a FeedDuck::AtomEntry type" do
    expect(subject).to be_a FeedDuck::AtomEntry
  end

  describe "#title" do
    it "returns the entry's title" do
      expect(subject.title).to eq "Atom-Powered Robots Run Amok"
    end
  end

  describe "#content" do
    it "returns the entry's content" do
      expect(subject.content).to eq "Some interesting content."
    end
  end

  describe "#published_at" do
    it "returns the entry's published date" do
      expect(subject.published_at).to eq Time.utc(2003, 12, 13, 18, 30, 02)
    end
  end

  describe "#author" do
    it "returns the entry's author name" do
      expect(subject.author).to eq "John Doe"
    end
  end

  describe "#url" do
    it "returns the entry's url" do
      expect(subject.url).to eq "http://example.org/2003/12/13/atom03"
    end
  end

  describe "#uuid" do
    it "returns the entry uuid" do
      expect(subject.uuid).to eq "urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a"
    end
  end

  describe "#to_h" do
    it "returns a hash representation of the entry" do
      expect(subject.to_h).to eq({
        title: "Atom-Powered Robots Run Amok",
        content: "Some interesting content.",
        published_at: Time.utc(2003, 12, 13, 18, 30, 02),
        author: "John Doe",
        url: "http://example.org/2003/12/13/atom03",
        uuid: "urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a",
      })
    end
  end
end

