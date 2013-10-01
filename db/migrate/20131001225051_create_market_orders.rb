class CreateMarketOrders < ActiveRecord::Migration
  def change
    create_table :market_orders do |t|
      t.integer :user_id
      t.integer :api_id
      t.integer :market_summary_id
      t.integer :order_id
      t.integer :station_id
      t.integer :vol_entered
      t.integer :vol_remaining
      t.integer :min_volume
      t.integer :order_state
      t.integer :type_id
      t.integer :reach
      t.integer :account_key
      t.integer :duration
      t.decimal :escrow
      t.decimal :price
      t.boolean :bid
      t.datetime :issued

      t.timestamps
    end
    add_index :market_orders, [:user_id, :api_id]
  end
end
