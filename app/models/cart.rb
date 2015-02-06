class Cart < ActiveRecord::Base
  include SafeDestroyed
  has_many :line_items

  def price
    line_items.to_a.sum(&:price)
  end
end
