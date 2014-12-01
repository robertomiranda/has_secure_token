require "active_model"
require 'securerandom'

module HasSecureToken
  extend ActiveSupport::Concern
  module ClassMethods
    def has_secure_token(*attrs)
      include InstanceMethodsOnActivation
      cattr_accessor :token_columns
      self.token_columns = attrs
      before_create :_generate_token
    end
  end

  module InstanceMethodsOnActivation
    def _generate_token
      self.class.token_columns.each do |attribute|
        self.send("#{attribute}=", loop do
          random_token = SecureRandom.hex
          break random_token unless self.class.exists?(attribute => random_token)
        end)
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  include HasSecureToken
end
