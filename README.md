[![Code Climate](https://codeclimate.com/github/simplereach/outbrain-api/badges/gpa.svg)](https://codeclimate.com/github/simplereach/outbrain-api)

# THIS IS CURRENTLY A WIP.
# PLEASE WAIT TILL 1.0 RELEASE TO USE IN PRODUCTION.


# Outbrain::Api

A simple thread safe wrapper for the outbrain api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'outbrain-api', github: 'adwyze/outbrain-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install outbrain-api

## Usage

 ```
   conn = Outbrain::Connection.new(
        user_name: username, user_password: password, token: token
      )

   req = Outbrain::Request.new(connect.api, connect.api_version)

   # all marketers associated with the user
   marketers = Outbrain::Api::Marketer.all(req).to_a

   # all campaigns for the marketer
   campaigns = marketers.first.campaigns(req)

   # all promoted links
   promoted_links = campaigns.first.promoted_links(req)

   # all campaign reports
   campaign_reports = markerters.first.campaign_reports(req, { from: '2018-01-01', to: '2018-01-10'})

   # all promoted link reports
   promoted_link_reports = markerters.first.promoted_link_reports(req, { from: '2018-01-01', to: '2018-01-10'})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/simplereach/outbrain-api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

