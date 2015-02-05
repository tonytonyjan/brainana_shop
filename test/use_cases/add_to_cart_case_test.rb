require 'test_helper'

class AddToCartCaseTest < ActiveSupport::TestCase
  def setup
    @cart = carts(:my_cart)
    @book = products(:book)
  end
  test "加入購物車" do
    AddToCartCase.new(@cart, @book).add_to_cart
    line_item = @cart.line_items.find_by product: @book
    assert line_item
    assert_equal line_item.quantity, 1
  end

  test "堆疊相同產品同價錢的項目" do
    3.times{ AddToCartCase.new(@cart, @book).add_to_cart }
    line_items = @cart.line_items.where(product: @book)
    assert_equal line_items.count, 1
    assert_equal line_items.first.quantity, 3
  end

  test "不同產品不同價錢需另計" do
    AddToCartCase.new(@cart, @book).add_to_cart
    @book.update price: 1000
    AddToCartCase.new(@cart, @book).add_to_cart
    assert_equal @cart.line_items.where(product: @book).count, 2
  end
end
