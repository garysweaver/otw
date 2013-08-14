[![Build Status](https://secure.travis-ci.org/garysweaver/otw.png?branch=master)][travis] [![Gem Version](https://badge.fury.io/rb/otw.png)][badgefury]

# otw

Provides `current_controller` in each model instance in a way that intends to be safe for concurrent access. Throws separation of concerns "out the window" for specific cases where having access to the controller, request, etc. are needed.

Should work with ActiveRecord, and may work with Mongoid and MongoMapper since we try to include the current_controller method on those if they exist.

Please don't misuse this. Models in Rails should not be concerned with the controller. However, sometimes you might want to have a callback that sets the `current_controller.request.remote_ip` in a field, etc.

Use at your own risk.

## How It Works

Uses an `around_filter` in base controller, so if you have any `before_filter` doing something where a model might need `current_controller`, that should work. If you have any trouble with filter order, you can manually call `prepend_around_filter :controller_around`, or ditch this and write your own, or just set/unset fields as needed on the models in your controller.

## Installation

In Gemfile:

```ruby
gem 'otw'
```

Then:

```
bundle install
```

## Usage

In each model instance, there is a controller attribute. ActiveRecord methods are now overriden to allow you to set it easily.

In your controller, just pass in the controller

It will be set if the controller 
```

## Testing

Has appraisals/travis build with some concurrency testing. TravisCI tests with Ruby 2.0.0, 1.9.3, ruby-head, jruby-19mode, jruby-head in Rails 3.2 and 4.0 via [TravisCI][travis]. Rails 3.1.x (3.1.12 at least) or its dependencies have some sqlite locking issue that fails with concurrency testing, so we don't concurrency test in Rails 3.1.x. We don't have tests for Mongoid or MongoMapper, yet, and not using them so consider those experimental. PR's and other feedback welcome.

## Contributing

Interested in adding support for another ORM, etc.? Just do a pull request, and if you'd like to join the team to help out, let us know.

## License

This gem is released under the [MIT license][lic].

[travis]: http://travis-ci.org/garysweaver/otw
[badgefury]: http://badge.fury.io/rb/otw
[lic]: https://github.com/garysweaver/out_the_window/blob/master/LICENSE
