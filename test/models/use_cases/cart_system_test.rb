require 'test_helper'
require 'minitest/mock'

module UseCases
  class CartSystemTest < ActiveSupport::TestCase
    def setup
      @cart = carts(:my_cart)
      @book = products(:book)
      @order_params = {
        first_name: :Weihang,
        last_name: :Jian,
        address: :Taiwan,
        email: :'tonytonyjan@gmail.com'
      }
    end

    test '加入購物車' do
      CartSystem.add_product_to_cart @book, @cart
      line_item = @cart.line_items.find_by product: @book
      assert line_item
      assert_equal 1, line_item.quantity
    end

    test '加入購物車時堆疊同商品、同價錢的項目' do
      3.times{ CartSystem.add_product_to_cart @book, @cart }
      line_items = @cart.line_items.where(product: @book)
      assert_equal 1, line_items.count
      assert_equal 3, line_items.first.quantity
    end

    test '加入購物車時不堆疊同商品、不同價錢的項目' do
      CartSystem.add_product_to_cart @book, @cart
      @book.increment! :price
      CartSystem.add_product_to_cart @book, @cart
      assert_equal 2, @cart.line_items.where(product: @book).count
    end

    test '從購物車產生訂單，訂單有與購物車相同的項目資訊' do
      CartSystem.add_product_to_cart @book, @cart
      line_item_ids = @cart.line_items.pluck(:id).sort
      order = CartSystem.create_order_from_cart @cart, @order_params
      assert_equal line_item_ids, order.line_items.pluck(:id).sort
    end

    test '建立訂單後清空購物車' do
      CartSystem.create_order_from_cart @cart, @order_params
      assert @cart.line_items.empty?
    end

    test '從訂單建立交易' do
      order = CartSystem.create_order_from_cart @cart, @order_params
      transaction = CartSystem.create_transaction_from_order order
      assert transaction.persisted?
    end

    test '已付款的訂單無法建立交易' do
      order = Minitest::Mock.new
      order.expect(:paid?, true)
      assert_raises CartSystem::OrderIsPaid do
        CartSystem.create_transaction_from_order order
      end
    end
  end
end