class User < ActiveRecord::Base
  has_secure_token
  has_secure_token :auth_token
  has_secure_token :not_generated_on_create_token, false
end
