class User < ActiveRecord::Base
  has_secure_token
  has_secure_token :auth_token
  has_secure_token :auth_secret, token_size: 80
end
