class AddCharIdToMarketOrders < ActiveRecord::Migration
  def change
    add_column :market_orders, :char_id, :integer
  end
end
