require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "自動產生訂單編號" do
    assert Order.create.slug
    assert_equal Order.create.slug.length, 6
  end
end
