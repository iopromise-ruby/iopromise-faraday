# iopromise-faraday

This gem provides a promise-based parallel interface to Faraday, based on [IOPromise](https://github.com/iopromise-ruby/iopromise).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iopromise-faraday'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install iopromise-faraday

## Usage

The pattern for using `IOPromise::Faraday` is very similar to regular Faraday, except rather than returning a response object, HTTP requests return promises that resolve to a response object. There is no explicit need to wrap parallel calls in a block, any pending requests will execute in parallel, automatically, when the promise(s) are synced.

```ruby
require 'iopromise/faraday'

conn = IOPromise::Faraday.new('https://github.com/')

promises = (1..3).map do
  conn.get('/status')
end

Promise.all(promises).then do |responses|
  responses.each_with_index do |response, i|
    puts "#{i}: #{response.body.strip} #{response.headers["x-github-request-id"]}"
  end
end.sync
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iopromise-ruby/iopromise-faraday. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/iopromise-ruby/iopromise-faraday/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the iopromise project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/iopromise-ruby/iopromise-faraday/blob/main/CODE_OF_CONDUCT.md).
