class Visitor
  extend ActiveModel::Callbacks
  include ActiveModel::SecurePassword
  include HasSecureToken

  define_model_callbacks :create

  has_secure_token :auth_token, :invitation_token, key_length: 30

  attr_accessor :auth_token, :invitation_token

  def self.exists?(attrs)
    false
  end
end
