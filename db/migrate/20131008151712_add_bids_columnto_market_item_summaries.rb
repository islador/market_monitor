class AddBidsColumntoMarketItemSummaries < ActiveRecord::Migration
  def up
  	add_column :market_item_summaries, :bid, :boolean
  end

  def down
  end
end
