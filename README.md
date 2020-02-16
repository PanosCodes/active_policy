[![Build Status](https://travis-ci.org/PanosCodes/active_policy.svg?branch=master)](https://travis-ci.org/PanosCodes/active_policy)
[![codecov](https://codecov.io/gh/PanosCodes/active_policy/branch/master/graph/badge.svg)](https://codecov.io/gh/PanosCodes/active_policy)

# ActivePolicy
Active policy is meant to be a way to authorize a request before hitting the controller.

## Installation

```ruby
gem 'active_policy'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_policy

## Usage

1. Register the ActivePolicyMiddleware inside application.rb

        ...
        config.middleware.use ActivePolicyMiddleware
        ...

 2. Inside your route.rb
    ```ruby
    post 'users/:user_id/segments', to: 'users#register_to_segment', policy: UserPolicy, policy_models: {user_id: User}
    ```

 3. Create the user_policy.rb

    ```ruby
    class UserPolicy < ActivePolicy
        # @param [User] user
        #
        # @return [TrueClass, FalseClass]
        def register_to_segment?(user)
            return true if @current_user.is_admin?
            return true if user.is_staff?
            false
        end
    end
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PanosCodes/active_policy.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
