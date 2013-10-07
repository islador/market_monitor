class CreateMarketItemSummaries < ActiveRecord::Migration
  def change
    create_table :market_item_summaries do |t|
      t.integer :user_id
      t.decimal :average_purchase_price
      t.decimal :average_sale_price
      t.decimal :average_percent_markup
      t.integer :total_vol_entered
      t.integer :total_vol_remaining
      t.integer :type_id
      t.integer :station_id
      t.integer :char_id
      t.integer :entity

      t.timestamps
    end
  end
end
