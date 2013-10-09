# == Schema Information
#
# Table name: market_item_summaries
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  average_purchase_price :decimal(, )
#  average_sale_price     :decimal(, )
#  average_percent_markup :decimal(, )
#  total_vol_entered      :integer
#  total_vol_remaining    :integer
#  type_id                :integer
#  station_id             :integer
#  char_id                :integer
#  entity                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  bid                    :boolean
#

class MarketItemSummaries < ActiveRecord::Base
  attr_accessible :average_percent_markup, :average_purchase_price, :average_sale_price, :char_id, :entity, :station_id, :total_vol_entered, :total_vol_remaining, :type_id, :user_id, :bid
end
