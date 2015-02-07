module Allpay
  class Form
    def initialize transaction, **override_params
      @transaction, @override_params = transaction, override_params
    end

    def params
      ret = {
        MerchantID: Settings.allpay.merchant_id,
        MerchantTradeNo: @transaction.trade_number,
        MerchantTradeDate: Time.now.strftime('%Y/%m/%d %H:%M:%S'),
        PaymentType: 'aio',
        TotalAmount: @transaction.order.price.to_i,
        TradeDesc: Settings.allpay.trade_desc,
        ItemName: item_name,
        ReturnURL: Settings.allpay.return_url,
        ClientBackURL: Settings.allpay.client_back_url,
        ChoosePayment: 'Credit'
      }.merge!(@override_params)
      ret[:CheckMacValue] = Allpay.client.make_mac(ret)
      ret
    end

    def item_name
      @transaction.order.line_items.includes(:product).map{|i| "#{i.product.name} x #{i.quantity}"}.join('#')
    end
  end
end
