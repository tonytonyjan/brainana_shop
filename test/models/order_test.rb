require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test '訂單不可刪' do
    assert_equal orders(:tony_order).destroy, false
  end
end
