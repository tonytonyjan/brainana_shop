class AllpayController < ApplicationController
  # post /allpay/form
  def form
    order = Order.find_by! slug: params[:slug]
    @allpay = Allpay::Form.new(order)
  rescue ActiveRecord::RecordNotFound
    # TODO
  end

  # post /allpay/callback
  def callback
  end
end
