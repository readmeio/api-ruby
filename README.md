# Readmeio

This is a Ruby API client for [ReadMe Build](https://readme.build). It's based on the [api spec](https://github.com/readmeio/api-spec).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'readmeio'
```
Or you can specify git url
```ruby
gem "readmeio", :git => "git@github.com:readmeio/api-ruby.git"
```



And then execute:

    $ bundle

Or install it yourself as:

    $ gem install readmeio

## Usage

```ruby
api = Readmeio::Api.new
api.config(YOUR_API_KEY_HERE)
response = api.run('math','multiply',{:numbers => [10,20,30]})    
```

## Running Test:

    $ rspec

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/readmeio/api-ruby/. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

