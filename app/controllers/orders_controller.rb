class OrdersController < ApplicationController
  before_action :set_line_items, only: %i[new create]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find params[:id]
    CartService.fetch_transactions @order if Rails.env.development?
    @line_items = @order.line_items.includes(:product)
    @total_price = @order.price
    @transactions = @order.transactions.order(created_at: :desc)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, "找不到訂單編號 ##{params[:id]}"
  end

  def new
    if current_cart.empty?
      redirect_to request.referer, alert: '購物車是空的'
    else
      @order = Order.new
    end
  end

  def create
    @order = CartService.create_order_from_cart current_cart, order_params
    redirect_to allpay_form_path(@order)
  rescue CartService::CartIsEmpty
    @order = Order.new order_params
    flash.now.alert = '購物車是空的'
    render :new
  rescue ActiveRecord::ActiveRecordError
    @order = Order.new order_params
    flash.now.alert = "出錯了：#{$!}"
    render :new
  end

private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :address)
  end

  def set_line_items
    @line_items = current_cart.line_items.includes(:product)
    @total_price = current_cart.price
  end
end
