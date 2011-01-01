require 'helper'

class TestMwkRubyUtils < Test::Unit::TestCase
  should "join" do
    assert_equal ['a', nil, 'b'].present_join, "a, b"
  end
end
