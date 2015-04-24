[![Build Status](https://travis-ci.org/robertomiranda/has_secure_token.png)](https://travis-ci.org/robertomiranda/has_secure_token)
[![Gem Version](https://badge.fury.io/rb/has_secure_token.svg)](http://badge.fury.io/rb/has_secure_token)
[![Dependency Status](https://gemnasium.com/robertomiranda/has_secure_token.svg)](https://gemnasium.com/robertomiranda/has_secure_token)
[![Code Climate](https://codeclimate.com/github/robertomiranda/has_secure_token/badges/gpa.svg)](https://codeclimate.com/github/robertomiranda/has_secure_token)

# HasSecureToken

HasSecureToken provides you an easily way to geneatre uniques random tokens for any model in ruby on rails. **SecureRandom::base58** is used to generate the 24-character unique token, so collisions are highly unlikely.

**Note** that it's still possible to generate a race condition in the database in the same way that **validates_uniqueness_of** can. You're encouraged to add a unique index in the database to deal

## Installation

Add this line to your application's Gemfile:

    gem 'has_secure_token'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install has_secure_token


## Setting your Model

The first step is to run the migration generator in order to add the token key field.

```ruby
rails g migration AddTokenToUsers token:string
=>
   invoke  active_record
   create    db/migrate/20150424010931_add_token_to_users.rb
```

Then need to run `rake db:migrate` to update the users table in the database. The next step is to update the model code

```ruby
# Schema: User(token:string, auth_token:string)
class User < ActiveRecord::Base
  has_secure_token
end

user = User.new
user.save
user.token # => "4kUgL2pdQMSCQtjE"
user.regenerate_token # => true
```

To use a custom column to store the token key field you can use the column_name option.

```ruby
# Schema: User(token:string, auth_token:string)
class User < ActiveRecord::Base
  has_secure_token :auth_token
end

user = User.new
user.save
user.auth_token # => "4kUgL2pdQMSCQtjE"
user.regenerate_auth_token # => true
```

## Contributing

1. Fork it ( https://github.com/robertomiranda/has_secure_token/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
