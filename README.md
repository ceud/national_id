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

## Validators
### Ruby
* `NationalID::Validator::Base`
  * `NationalID::Validator::Brazil`
  * `NationalID::Validator::Norway`
  * `NationalID::Validator::Poland`
  * `NationalID::Validator::Turkey`

## Javascript
* `NationalID.Validator.Base`
  * `NationalID.Validator.Brazil`
  * `NationalID.Validator.Norway`
  * `NationalID.Validator.Poland`
  * `NationalID.Validator.Turkey`

## Usage
### Ruby
```ruby
# Defaults to Base validator
nid = NationalID::Validator.new
nid.valid?

# Validator can be specified at instantiation
nid = NationalID::Validator.new(NationalID::Validator::Brazil)
nid.valid?('111-111-111-11')

# Change the validator at runtime
nid.validator = NationalID::Validator::Turkey
nid.valid?('123-456-789-50')
```

### Javascript
```javascript
NationalID.validator = NationalID.Validators.Brazil;
NationalID.valid('111-111-111-11');

NationalID.validator = NationalID.Validators.Turkey;
NationalID.valid('123-456-789-50');
```

## Verify
```
rails new nid_test
cd nid_test/
echo 'gem "national_id", :path => "/path/to/gem"' >> Gemfile
bundle install
echo '//= require national_id' >> app/assets/javascripts/application.js
rails server
curl http://localhost:3000/assets/national_id.js
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
