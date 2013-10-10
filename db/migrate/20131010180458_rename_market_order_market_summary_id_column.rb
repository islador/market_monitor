class RenameMarketOrderMarketSummaryIdColumn < ActiveRecord::Migration
  def up
  	rename_column :market_orders, :market_summary_id, :market_item_summary_id
  end

  def down
  end
end
