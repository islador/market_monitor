class MarketOrder < ActiveRecord::Base
  attr_accessible :account_key, :api_id, :bid, :duration, :escrow, :issued, :market_summary_id, :min_volume, :order_id, :order_state, :price, :reach, :station_id, :type_id, :user_id, :vol_entered, :vol_remaining
end
