module SafeDestroyed
  extend ActiveSupport::Concern

  included do
    before_destroy :line_items_must_be_empty
  end

private

  def line_items_must_be_empty
    if line_items.empty?
      true
    else
      errors.add(:line_items, :must_be_empty)
      false
    end
  end
end