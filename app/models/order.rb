class Order < ActiveRecord::Base
  include SafeDestroyed
  has_many :line_items
  before_create :generate_slug

  def to_param
    slug
  end

  def price
    line_items.to_a.sum(&:price)
  end

private

  def generate_slug
    self.slug = SecureRandom.hex(3)
  end
end
