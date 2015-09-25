require "test_helper"

class SecureTokenTest < MiniTest::Unit::TestCase
  def setup
    @user = User.new
  end

  def test_token_values_are_generated_for_specified_attributes_and_persisted_on_save
    @user.save
    refute_nil @user.token
    refute_nil @user.auth_token
  end

  def test_regenerating_the_secure_token
    @user.save
    old_token = @user.token
    old_auth_token = @user.auth_token
    @user.regenerate_token
    @user.regenerate_auth_token

    refute_equal @user.token, old_token
    refute_equal @user.auth_token, old_auth_token
  end

  def test_token_value_not_overwritten_when_present
    @user.token = "custom-secure-token"
    @user.save

    assert_equal @user.token, "custom-secure-token"
  end
end
