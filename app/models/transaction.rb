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