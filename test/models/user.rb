class User
  extend ActiveModel::Callbacks
  include ActiveModel::Validations
  include HasSecureToken

  define_model_callbacks :create
  attr_accessor :auth_token, :invitation_token

  has_secure_token :auth_token, :invitation_token

  def self.exists?(attrs)
    false
  end
end
