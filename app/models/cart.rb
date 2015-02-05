class Cart < ActiveRecord::Base
  include SafeDestroyed
  has_many :line_items
end
