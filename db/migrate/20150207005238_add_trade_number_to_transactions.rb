class AddTradeNumberToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :trade_number, :string
    add_index :transactions, :trade_number, unique: true
  end
end
