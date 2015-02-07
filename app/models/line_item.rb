class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order
  before_destroy :check_order_existence

  def price
    unit_price * quantity
  end

private
  def check_order_existence
    unless order_id.nil?
      errors.add(:order, :is_not_empty)
      false
    end
  end
end
