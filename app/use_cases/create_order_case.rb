class CreateOrderCase
  def initialize cart, order_params
    @cart, @order_params = cart, order_params
  end

  def create_order
    Order.transaction do
      order = Order.create! @order_params
      @cart.line_items.update_all(order_id: order.id, cart_id: nil)
      order
    end
  end
end