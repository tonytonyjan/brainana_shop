class AllpayController < ApplicationController
  # post /allpay/form/:order_id
  def form
    order = Order.find params[:order_id]
    transaction = UseCases::CartSystem.create_transaction_from_order order
    @params = Allpay::Form.new(transaction, ClientBackURL: order_url(order)).params
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "查無訂單編號 ##{params[:order_id]}"
  rescue UseCases::CartSystem::OrderIsPaid
    redirect_to alert: "訂單 ##{order.id} 已經付款了"
  end

  # post /allpay/callback
  def callback
    Transaction.find_by!(trade_number: params[:MerchantTradeNo]).update!(params: request.POST)
    render text: :'1|OK'
  rescue ActiveRecord::RecordNotFound
    render text: :'0|transaction record not found'
  rescue ActiveRecord::RecordNotSaved
    render text: :'0|transaction not saved'
  rescue
    render text: "0|#{$!}"
  end
end
