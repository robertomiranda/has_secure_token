[![Build Status](https://travis-ci.org/robertomiranda/has_secure_token.png)](https://travis-ci.org/robertomiranda/has_secure_token)
[![Gem Version](https://badge.fury.io/rb/has_secure_token.svg)](http://badge.fury.io/rb/has_secure_token)
[![Dependency Status](https://gemnasium.com/robertomiranda/has_secure_token.svg)](https://gemnasium.com/robertomiranda/has_secure_token)
[![Code Climate](https://codeclimate.com/github/robertomiranda/has_secure_token/badges/gpa.svg)](https://codeclimate.com/github/robertomiranda/has_secure_token)

# HasSecureToken

## Installation

Add this line to your application's Gemfile:

    gem 'has_secure_password'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install has_secure_password

##Setting your Model

```ruby
class User
  has_secure_token :token1, :token2
end

user = User.create
user.token1 => "44539a6a59835a4ee9d7b112b48cd76e"
user.token2 => "226dd46af6be78953bde1641622497a8"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/has_secure_password/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
