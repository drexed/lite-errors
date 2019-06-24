# Lite::Errors

[![Gem Version](https://badge.fury.io/rb/lite-errors.svg)](http://badge.fury.io/rb/lite-errors)
[![Build Status](https://travis-ci.org/drexed/lite-errors.svg?branch=master)](https://travis-ci.org/drexed/lite-errors)

Lite::Errors provides an API for generating and accessing error messages.
There are few handy methods for interacting with errors so we encourage you to look through the lib files.

*NOTE:* If you are coming from `ActiveErrors`, please read the [port](#port) section.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lite-errors'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lite-errors

## Table of Contents

* [Port](#port)
* [Usage](#usage)

## Port

`Lite::Errors` is compatible port of [ActiveErrors](https://github.com/drexed/active_errors).

Switching is as easy as renaming `ActiveError::Messages` to `Lite::Errors::Messages`.

## Usage

```ruby
class Shipment

  def errors
    @errors ||= Lite::Errors::Messages.new
  end

  def messages
    @errors.full_messages
  end

  def process
    ShipmentItem.each do |item|
      item.add_to_box!
    rescue Shipment::OutOfStock => e
      errors.add(item.name, :out_of_stock)
    rescue Shipment::DoesNotExist => e
      errors[item.name] = I18n.t('errors.does_not_exist')
    rescue ActiveRecord::RecordInvalid
      errors.merge!(item.errors)
    end
  end

end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lite-errors. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lite::Errors project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lite-errors/blob/master/CODE_OF_CONDUCT.md).
