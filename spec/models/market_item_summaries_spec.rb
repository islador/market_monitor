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

require 'spec_helper'

describe MarketItemSummaries do
  pending "add some examples to (or delete) #{__FILE__}"
end
