# == Schema Information
#
# Table name: items
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string(255)
#  type_id         :integer
#  volume          :float
#  market_group_id :integer
#

class Item < ActiveRecord::Base
   attr_accessible :name, :type_id, :volume, :market_group_id
end
