require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test '屬於購物車時，可刪' do
    assert line_items(:one).destroy
  end
  test '屬於訂單時，不可刪' do
    UseCases::CartSystem.create_order_from_cart carts(:my_cart),
      first_name: :Weihang,
      last_name: :Jian,
      address: :Taiwan,
      email: :'tonytonyjan@gmail.com'
    assert_equal false, line_items(:one).destroy
  end
end
