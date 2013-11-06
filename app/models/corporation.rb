# == Schema Information
#
# Table name: corporations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  corp_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :integer
#  wallet_0     :string(255)
#  wallet_1     :string(255)
#  wallet_2     :string(255)
#  wallet_3     :string(255)
#  wallet_4     :string(255)
#  wallet_5     :string(255)
#  wallet_6     :string(255)
#

#Basic model for holding corporation IDs and Names for use in owner filtering on mis_show.
class Corporation < ActiveRecord::Base
  attr_accessible :corp_id, :name, :wallet_0, :wallet_1, :wallet_2, :wallet_3, :wallet_4, :wallet_5, :wallet_6
  
  belongs_to :character
end
