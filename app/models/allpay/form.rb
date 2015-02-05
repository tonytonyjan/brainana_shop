module Allpay
  class Form
    include ActiveModel::Model
    attr_accessor :MerchantID, :MerchantTradeNo, :MerchantTradeDate, :PaymentType,
      :TotalAmount, :TradeDesc, :ItemName, :ReturnURL, :ClientBackURL, :ChoosePayment,
      :CheckMacValue

    def initialize order
      @order = order

      @MerchantID = Settings.allpay.merchant_id
      @MerchantTradeNo = order.slug
      @MerchantTradeDate = Time.now.strftime('%Y/%m/%d %H:%M:%S')
      @PaymentType = 'aio'
      @TotalAmount = order.price.to_i
      @TradeDesc = Settings.allpay.trade_desc
      @ItemName = item_name
      @ReturnURL = Settings.allpay.return_url
      @ClientBackURL = 'http://localhost:3000'# order_url(order, host: 'localhost:3000')
      @ChoosePayment = 'Credit'
      params = {
        MerchantID: @MerchantID,
        MerchantTradeNo: @MerchantTradeNo,
        MerchantTradeDate: @MerchantTradeDate,
        PaymentType: @PaymentType,
        TotalAmount: @TotalAmount,
        TradeDesc: @TradeDesc,
        ItemName: @ItemName,
        ReturnURL: @ReturnURL,
        ClientBackURL: @ClientBackURL,
        ChoosePayment: @ChoosePayment
      }
      @CheckMacValue = Allpay.client.make_mac(params)
    end

    def item_name
      @order.line_items.includes(:product).map{|i| "#{i.product.name} x #{i.quantity}"}.join('#')
    end
  end
end
