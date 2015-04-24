require "test_helper"

class SecureRandomTest < Minitest::Test
  def test_base58
    s1 = SecureRandom.base58
    s2 = SecureRandom.base58

    refute_equal s1, s2
    assert_equal 16, s1.length
  end

  def test_base58_with_length
    s1 = SecureRandom.base58(24)
    s2 = SecureRandom.base58(24)

    refute_equal s1, s2
    assert_equal 24, s1.length
  end
end
