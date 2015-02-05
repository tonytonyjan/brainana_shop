class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :slug

      t.timestamps null: false
    end
  end
end
