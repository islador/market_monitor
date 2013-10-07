class MarketItemSummaries < ActiveRecord::Base
  attr_accessible :average_percent_markup, :average_purchase_price, :average_sale_price, :char_id, :entity, :station_id, :total_vol_entered, :total_vol_remaining, :type_id, :user_id
end
