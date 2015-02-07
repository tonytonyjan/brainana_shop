class Order < ActiveRecord::Base
  has_many :line_items
  has_many :transactions
  before_destroy :can_not_be_destroyed

  def price
    line_items.to_a.sum(&:price)
  end

  def paid?
    transactions.exists?("params -> 'RtnCode' = '1'")
  end

private

  def can_not_be_destroyed
    false
  end
end
