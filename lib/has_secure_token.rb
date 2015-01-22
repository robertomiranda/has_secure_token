require "active_model"
require 'securerandom'

module HasSecureToken
  extend ActiveSupport::Concern
  module ClassMethods
    # Example using Active Record (which automatically includes ActiveModel::SecurePassword):
    #
    #   # Schema: User(auth_token:string, invitation_token:string)
    #   class User < ActiveRecord::Base
    #     has_secure_token :auth_token, :invitation_token
    #   end
    #
    #   user = User.new
    #   user.save
    #   user.auth_token # => "44539a6a59835a4ee9d7b112"
    #   user.invitation_token # => "226dd46af6be78953bde1648"
    #   user.regenerate_auth_token! # => true
    #   user.regenerate_invitation_token! # => true
    def has_secure_token(*args)
      # Load securerandom only when has_secure_key is used.
      require 'securerandom'
      include InstanceMethodsOnActivation
      cattr_accessor :token_columns, :options
      options = args.extract_options!

      key_length = options.fetch(:key_length, 24)
      bytes = ((key_length*3.0)/4.0)

      args.each do |attribute|
        define_method("regenerate_#{attribute}!") do
          send(:generate_unique_secure_token, attribute, bytes, key_length)
          save
        end
      end

      before_create do
        args.each do |attribute|
          self.generate_unique_secure_token(attribute, bytes, key_length)
        end
      end
    end
  end

  module InstanceMethodsOnActivation
    def generate_unique_secure_token(attribute, bytes, key_length)
      self.send("#{attribute}=", loop do
        random_token =  SecureRandom.base64(bytes)[0..key_length-1]
        break random_token unless self.class.exists?(attribute => random_token)
      end)
    end
  end
end

ActiveSupport.on_load(:active_record) do
  include HasSecureToken
end
