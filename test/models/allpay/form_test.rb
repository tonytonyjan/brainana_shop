require 'test_helper'
class Allpay::FormTest < ActiveSupport::TestCase
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

  test '#item_name' do
    3.times{ AddToCartCase.new(@cart, @book).add_to_cart }
    order = CreateOrderCase.new(@cart, @order_params).create_order
    f = Allpay::Form.new(order)
    assert_equal f.item_name, '繼承概念衫 x 20#Ruby on Rails 自習手冊 - 成為鐵道工之路 x 3'
  end

  test 'Mac Value 是正確的' do
    f = Allpay::Form.new(orders(:tony_order))
    p f.CheckMacValue
    # TODO
  end
end
