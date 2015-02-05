class OrdersController < ApplicationController
  def show
    @order = Order.find_by slug: params[:id]
  end

  def new
    @order = Order.new
  end

  def create
    @order = CreateOrderCase.new(current_cart, order_params).create_order
    redirect_to @order
  rescue
    render :new
  end

private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :address)
  end
end
