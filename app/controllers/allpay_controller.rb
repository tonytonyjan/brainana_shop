class AllpayController < ApplicationController
  # post /allpay/form
  def form
    order = Order.find_by! slug: params[:slug]
    @allpay = Allpay::Form.new(order, ClientBackURL: order_url(order))
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "查無訂單編號 ##{params[:slug]}"
  end

  # post /allpay/callback
  def callback
  end
end
