class Transaction < ActiveRecord::Base
  belongs_to :order
  after_initialize :generate_trade_number
  validate :check_trade_number, :check_mac_value, on: :update

  def to_param
    trade_number
  end

private

  def generate_trade_number
    self.trade_number = SecureRandom.hex(3) if trade_number.nil?
  end

  def check_trade_number
    errors.add(:params, 'wrong trade number') unless params['MerchantTradeNo'] == trade_number
  end

  def check_mac_value
    errors.add(:params, 'wrong mac value') unless Allpay.client.verify_mac(params)
  end
end