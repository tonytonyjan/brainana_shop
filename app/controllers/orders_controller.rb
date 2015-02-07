class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find params[:id]
    UseCases::CartSystem.fetch_transactions @order if Rails.env.development?
    @line_items = @order.line_items.includes(:product)
    @total_price = @order.price
    @transactions = @order.transactions.order(created_at: :desc)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, "找不到訂單編號 ##{params[:id]}"
  end

  def new
    @order = Order.new
    @line_items = current_cart.line_items.includes(:product)
    @total_price = current_cart.price
  end

  def create
    @order = UseCases::CartSystem.create_order_from_cart current_cart, order_params
    redirect_to allpay_form_path(@order)
  rescue ActiveRecord::ActiveRecordError
    render :new, alert: "出錯了：#{$!}"
  end

private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :address)
  end
end
