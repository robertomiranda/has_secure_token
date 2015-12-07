[![Build Status](https://travis-ci.org/robertomiranda/has_secure_token.png)](https://travis-ci.org/robertomiranda/has_secure_token)
[![Gem Version](https://badge.fury.io/rb/has_secure_token.svg)](http://badge.fury.io/rb/has_secure_token)
[![Dependency Status](https://gemnasium.com/robertomiranda/has_secure_token.svg)](https://gemnasium.com/robertomiranda/has_secure_token)
[![Code Climate](https://codeclimate.com/github/robertomiranda/has_secure_token/badges/gpa.svg)](https://codeclimate.com/github/robertomiranda/has_secure_token)

# HasSecureToken

HasSecureToken provides an easy way to generate uniques random tokens for any model in ruby on rails. **SecureRandom::base58** is used to generate the 24-character unique tokens, so collisions are highly unlikely.

**Note** If you're worried about possible collissions, there's a way to generate a race condition in the database in the same way that [validates_uniqueness_of](http://api.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html) can. You're encouraged to add an unique index in the database to deal with this even more unlikely scenario.

## Installation

Add this line to your application's Gemfile:

    gem 'has_secure_token'

And then run:

    $ bundle

Or install it yourself as:

    $ gem install has_secure_token

## Setting your Model

The first step is to generate a migration in order to add the token key field.

```ruby
rails g migration AddTokenToUsers token:string
=>
   invoke  active_record
   create    db/migrate/20150424010931_add_token_to_users.rb
```

Then run `rake db:migrate` in order to update users table in the database. The next step is to add `has_secure_token`
 to the model:
```ruby
# Schema: User(token:string, auth_token:string)
class User < ActiveRecord::Base
  has_secure_token
end

user = User.new
user.save
user.token # => "pX27zsMN2ViQKta1bGfLmVJE"
user.regenerate_token # => true
```

To use a custom column to store the token key field you can specify the column_name option. See example above (e.g: auth_token):

```ruby
# Schema: User(token:string, auth_token:string)
class User < ActiveRecord::Base
  has_secure_token :auth_token
end

user = User.new
user.save
user.auth_token # => "pX27zsMN2ViQKta1bGfLmVJE"
user.regenerate_auth_token # => true
```

## Running tests

Running

```shell
$ rake test
```

Should return

```shell
5 runs, 9 assertions, 0 failures, 0 errors, 0 skips
```

## Contributing

1. Fork it ( https://github.com/robertomiranda/has_secure_token/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
