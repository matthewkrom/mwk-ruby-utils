require 'helper'

class TestMwkRubyUtils < Test::Unit::TestCase
  should "join" do
    assert_equal ['a', nil, 'b'].present_join, "a, b"
  end
  
  should "hashify numbers" do
    assert_equal [1, 2, 3].hashify_single, {1 => 1, 2 => 2, 3 => 3}
  end

  should "hashify with a sym" do
    assert_equal [[1, 1], [2, 2], [3,3]].hashify_single(:first), {1 => [1, 1], 2 => [2, 2], 3 => [3, 3]}
  end
end
