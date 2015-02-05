class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :order, index: true
      t.hstore :params

      t.timestamps null: false
    end
    add_foreign_key :transactions, :orders
  end
end
