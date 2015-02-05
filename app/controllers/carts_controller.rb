class CartsController < ApplicationController
  def show
    @line_items = LineItem.all.includes(:product)
  end
end
