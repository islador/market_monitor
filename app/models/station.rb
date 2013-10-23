# == Schema Information
#
# Table name: stations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  station_id :integer
#

class Station < ActiveRecord::Base
   attr_accessible :name, :station_id
end
