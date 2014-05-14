# Feed Duck

This gem wraps the default [RSS::Parser lib](http://ruby-doc.org/stdlib-2.0.0/libdoc/rss/rdoc/RSS/Parser.html) from Ruby and provides an uniform interface (therefore the "duck") for reading data from Atom and RSS feeds (therefore the "feed").

## Installation

Add this line to your application's Gemfile:

    gem 'feed_duck'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install feed_duck

## Usage

### Basic usage

Feed duck is meant to be used just like `RSS:Parser`. It expects the feed XML as an argument(either from a file or, like in most cases, from a URL), and returns a `FeedDuck::Feed` object with the parsed data. Let's see an example:

```
require 'feed_duck'
require 'uri'

url = 'http://www.ruby-lang.org/en/feeds/news.rss'
open(url) do |feed|
  feed = FeedDuck::Parser.parse(feed)
  
  feed.title
  # => "Ruby News"
  
  feed.entries.first.title
  # => Ruby 2.1.2 is released
end
```

Conversely, if you'd like to read an Atom feed, the interface is exactly the same.

```
require 'feed_duck'
require 'uri'

url = 'http://www.ruby-lang.org/en/feeds/news.atom'
open(url) do |feed|
  feed = FeedDuck::Parser.parse(feed)
  
  feed.title
  # => "Ruby News"
  
  feed.entries.first.title
  # => Ruby 2.1.2 is released
end
```

Providing the same interface for both standards is where this gem really shines. If you were to read an entry's published date in a RSS feed using the standard Ruby lib, this is what you'd have to do:

```
feed.channel.items.first.pubDate
# => 2014-05-13 22:25:02 -0300
```

If this was an Atom feed, the interface would be *very* different:

```
feed.entries.first.updated.content
# => 2014-05-13 22:25:02 -0300
```

Now using feed duck, for either an Atom or RSS feed:

```
feed.entries.first.published_at
# => 2014-05-13 22:25:02 -0300
```

### Available methods:

Feed Duck's interface was designed to be minimal. Here are the available methods:

* `title`: Feed title
* `url`: Feed URL
* `description`: Feed short description
* `entries`: An array containing each entry from the feed.

Each entry also provides:

* `title`: Entry's title
* `content`: The entry content itself.
* `published_at`: Date of publication or last update.
* `author`: Author's name
* `url`: Permalink to this post
* `id`: Unique post ID.

If for some reason you need other methods, feel free to fork the project, add them and send me a pull request. You can also ask me, but I cannot promise anything :)

### to_h

Feed duck is compliant with the Ruby 2.0 standard `to_h` inteface for converting an object to a Hash:

```
feed.to_h
# => {
#     title: "Example Feed",
#     url: "http://example.org/",
#     subtitle: "A subtitle.",
#     description: "A subtitle.",
#     entries: [{
#       title: "Atom-Powered Robots Run Amok",
#       content: "Some interesting content.",
#       published_at: Time.utc(2003, 12, 13, 18, 30, 02),
#       author: "John Doe",
#       url: "http://example.org/2003/12/13/atom03",
#       id: "urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a"
#     }]
# }
```

You can also generate hashes of individual entries:

```
feed.entry.first.to_h
# => {
#       title: "Atom-Powered Robots Run Amok",
#       content: "Some interesting content.",
#       published_at: Time.utc(2003, 12, 13, 18, 30, 02),
#       author: "John Doe",
#       url: "http://example.org/2003/12/13/atom03",
#       id: "urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a"
#    }
# }
```

## Contributing

1. Fork it ( https://github.com/abernardes/feed_duck/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
