require 'active_record'
module ActiveRecord
  module SecureToken
    extend ActiveSupport::Concern

    module ClassMethods
      # Example using has_secure_token
      #
      #   # Schema: User(token:string, auth_token:string)
      #   class User < ActiveRecord::Base
      #     has_secure_token
      #     has_secure_token :auth_token
      #     has_secure_token uniq: true
      #     has_secure_token :auth_token, uniq: true, length: 16
      #   end
      #
      #   user = User.new
      #   user.save
      #   user.token # => "pX27zsMN2ViQKta1bGfLmVJE"
      #   user.auth_token # => "77TMHrHJFvFDwodq8w7Ev2m7"
      #   user.regenerate_token # => true
      #   user.regenerate_auth_token # => true
      #
      # SecureRandom::base58 is used to generate the 24-character unique token, so collisions are highly unlikely.
      #
      # Note that it's still possible to generate a race condition in the database in the same way that
      # <tt>validates_uniqueness_of</tt> can. You're encouraged to add a unique index in the database to deal
      # with this even more unlikely scenario.

      def has_secure_token(attribute = :token, options = {})
        attribute, options = :token, attribute if options.empty? && attribute.is_a?(Hash)

        # Load securerandom only when has_secure_token is used.
        require 'active_support/core_ext/securerandom'

        define_method("regenerate_#{attribute}") do
          token = self.class.generate_unique_secure_token(attribute, options)
          update_attributes attribute => token
        end

        before_create do
          unless self.send("#{attribute}?")
            self.send("#{attribute}=", self.class.generate_unique_secure_token(attribute, options))
          end
        end
      end

      def generate_unique_secure_token(attribute, options)
        if options[:uniq]
          loop do
            random_token = secure_random_token(options)
            break random_token unless self.exists?(attribute => 'token')
          end
        else
          secure_random_token(options)
        end
      end

      def secure_random_token(options)
        length = options[:length] || 24
        SecureRandom.base58(length)
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::SecureToken)
