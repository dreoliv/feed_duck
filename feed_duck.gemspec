# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feed_duck/version'

Gem::Specification.new do |spec|
  spec.name          = "feed_duck"
  spec.version       = FeedDuck::VERSION
  spec.authors       = ["André Bernardes"]
  spec.email         = ["abernardes@gmail.com"]
  spec.summary       = %q{This gem parses RSS and Atom feeds into Ruby objects.}
  spec.description   = %q{This gem parses RSS and Atom feeds and provides an uniform ruby-object interface to access data from
                          both feed standards.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
