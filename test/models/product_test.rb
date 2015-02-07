require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test '不可刪被加入購物車或是訂單的產品' do
    product = products(:t_shirt)
    assert_equal false, product.destroy
  end
end
