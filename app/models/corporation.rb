# == Schema Information
#
# Table name: corporations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  corp_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

#Basic model for holding corporation IDs and Names for use in owner filtering on mis_show.
class Corporation < ActiveRecord::Base
  attr_accessible :corp_id, :name
end
