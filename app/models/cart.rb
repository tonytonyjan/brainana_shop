class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def price
    line_items.to_a.sum(&:price)
  end
end
