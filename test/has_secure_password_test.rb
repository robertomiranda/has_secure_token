require "test_helper"

class HasSecureTokenTest < MiniTest::Unit::TestCase
  def setup
    @user = User.new
    @user.run_callbacks :create
  end

  def test_assing_token_values
    assert_not_nil @user.auth_token
    assert_not_nil @user.invitation_token
  end
end
