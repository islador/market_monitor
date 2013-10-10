# == Schema Information
#
# Table name: market_orders
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  api_id            :integer
#  market_summary_id :integer
#  order_id          :integer
#  station_id        :integer
#  vol_entered       :integer
#  vol_remaining     :integer
#  min_volume        :integer
#  order_state       :integer
#  type_id           :integer
#  reach             :integer
#  account_key       :integer
#  duration          :integer
#  escrow            :decimal(, )
#  price             :decimal(, )
#  bid               :boolean
#  issued            :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  char_id           :integer
#

# Market Orders to Model Map
# | range | reach | Range is a reserved word in rails and most SQL databases. |


class MarketOrder < ActiveRecord::Base
  attr_accessible :account_key, :api_id, :bid, :duration, :escrow, :issued, :market_item_summary_id, :min_volume, :order_id, :order_state, :price, :reach, :station_id, :type_id, :user_id, :vol_entered, :vol_remaining, :char_id

  belongs_to :api
  belongs_to :user

  validates :order_id, presence: true, uniqueness: true
end
