require "test_helper"

class HasSecureTokenTest < MiniTest::Unit::TestCase
  def setup
    @user = User.new
    @user.run_callbacks :create
    @visitor = Visitor.new
    @visitor.run_callbacks :create
  end

  def test_assing_token_values
    assert_not_nil @user.auth_token
    assert_not_nil @user.invitation_token
  end

  def test_default_length_of_secure_token_is_set_to_24
    assert_equal 24, @user.auth_token.length
    assert_equal 24, @user.invitation_token.length
  end

  def test_create_record_with_customised_length_of_secure_token
    assert_equal 30, @visitor.auth_token.length
    assert_equal 30, @visitor.invitation_token.length
  end

  def test_regenerate_the_secure_key_for_the_attribute
    old_auth_token = @user.auth_token
    old_invitation_token = @user.invitation_token
    @user.regenerate_auth_token!
    @user.regenerate_invitation_token!

    assert @user.auth_token != old_auth_token
    assert @user.invitation_token != old_invitation_token
    assert_equal 24, @user.auth_token.length
    assert_equal 24, @user.invitation_token.length
  end
end
