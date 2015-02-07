class RemoveSlugFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :slug, :string
  end
end
