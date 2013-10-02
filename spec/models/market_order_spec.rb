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

require 'spec_helper'

describe MarketOrder do
  let(:user) {FactoryGirl.create(:user)}

  
end
