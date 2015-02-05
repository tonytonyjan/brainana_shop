require 'test_helper'
class CreateOrderCaseTest < ActiveSupport::TestCase
  def setup
    @cart = carts(:my_cart)
    @book = products(:book)
    @order_params = {
      first_name: :Weihang,
      last_name: :Jian,
      address: :Taiwan,
      email: :'tontonyjan@gmail.com'
    }
  end

  test "建立的訂單可取得項目資訊" do
    AddToCartCase.new(@cart, @book).add_to_cart
    line_item_ids = @cart.line_items.pluck(:id).sort
    order = CreateOrderCase.new(@cart, @order_params).create_order
    assert_equal line_item_ids, order.line_items.pluck(:id).sort
  end

  test "建立訂單後清空購物車" do
    order = CreateOrderCase.new(@cart, @order_params).create_order
    assert @cart.line_items.empty?
  end
end