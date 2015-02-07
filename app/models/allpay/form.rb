module Allpay
  class Form
    def initialize order, **override_params
      @order, @override_params = order, override_params
    end

    def params
      params = {
        MerchantID: Settings.allpay.merchant_id,
        MerchantTradeNo: order.slug,
        MerchantTradeDate: Time.now.strftime('%Y/%m/%d %H:%M:%S'),
        PaymentType: 'aio',
        TotalAmount: order.price.to_i,
        TradeDesc: Settings.allpay.trade_desc,
        ItemName: item_name,
        ReturnURL: Settings.allpay.return_url,
        ClientBackURL: Settings.allpay.client_back_url,
        ChoosePayment: 'Credit'
      }.merge!(@override_params)
      params[:CheckMacValue] = Allpay.client.make_mac(params)
    end

    def item_name
      @order.line_items.includes(:product).map{|i| "#{i.product.name} x #{i.quantity}"}.join('#')
    end
  end
end
