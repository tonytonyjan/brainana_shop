class OrdersController < ApplicationController
  def show
    @order = Order.find_by slug: params[:id]
    @line_items = @order.line_items.includes(:product)
    @total_price = @order.price
  end

  def new
    @order = Order.new
    @line_items = current_cart.line_items.includes(:product)
    @total_price = current_cart.price
  end

  def create
    @order = CreateOrderCase.new(current_cart, order_params).create_order
    redirect_to allpay_form_path(@order.slug)
  rescue
    render :new, alert: '出錯了'
  end

private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :address)
  end
end
