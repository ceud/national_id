# NationalID

Defines families of algorithms to validate national ID formats of various countries.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'national_id'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install national_id

## Usage

```ruby
nid = NationalID.new(NationalID::Validator::Brazil.new('111-111-111-11'))
nid.validate

# Change the validator at runtime
nid.validator = NationalID::Validator::Turkey.new('123-456-789-50')
nid.validator = NationalID::Validator::None.new
nid.validate
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/national_id/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
