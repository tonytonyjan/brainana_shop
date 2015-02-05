class CartsController < ApplicationController
  def show
    @line_items = current_cart.line_items.includes(:product)
  end
end
