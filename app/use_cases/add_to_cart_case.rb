class AddToCartCase
  def initialize cart, product
    @cart, @product = cart, product
  end

  def add_to_cart
    if line_item = @cart.line_items.find_by(product: @product, unit_price: @product.price)
      line_item.increment!(:quantity)
    else
      @cart.line_items.create(product: @product, unit_price: @product.price, quantity: 1)
    end
  end
end