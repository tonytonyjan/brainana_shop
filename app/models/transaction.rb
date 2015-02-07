class Transaction < ActiveRecord::Base
  belongs_to :order
  after_initialize :generate_trade_number

  def to_param
    trade_number
  end

private

  def generate_trade_number
    self.trade_number = SecureRandom.hex(3) if trade_number.nil?
  end
end
# PaymentDate: 2015/02/06 07:40:09
# PaymentTypeChargeFee: 106
# TradeDate: 2015/02/06 07:39:30
# TradeAmt: 5300
# PaymentType: Credit_CreditCard
# RtnCode: 1
# MerchantID: 2000132
# TradeNo: 1502060739302521
# CheckMacValue: 13D9CC434739B5ED9313B079718DDAE3
# MerchantTradeNo: 865a7b
# RtnMsg: 交易成功
# SimulatePaid: 0