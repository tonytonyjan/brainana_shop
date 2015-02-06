module Allpay
  class Form
    attr_accessor :MerchantID, :MerchantTradeNo, :MerchantTradeDate, :PaymentType,
      :TotalAmount, :TradeDesc, :ItemName, :ReturnURL, :ClientBackURL, :ChoosePayment,
      :CheckMacValue

    def initialize order, **override
      @order = order

      @MerchantID = override[:MerchantID] || Settings.allpay.merchant_id
      @MerchantTradeNo = override[:MerchantTradeNo] || order.slug
      @MerchantTradeDate = override[:MerchantTradeDate] || Time.now.strftime('%Y/%m/%d %H:%M:%S')
      @PaymentType = override[:PaymentType] || 'aio'
      @TotalAmount = override[:TotalAmount] || order.price.to_i
      @TradeDesc = override[:TradeDesc] || Settings.allpay.trade_desc
      @ItemName = override[:ItemName] || item_name
      @ReturnURL = override[:ReturnURL] || Settings.allpay.return_url
      @ClientBackURL = override[:ClientBackURL] || Settings.allpay.client_back_url
      @ChoosePayment = override[:ChoosePayment] || 'Credit'
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
