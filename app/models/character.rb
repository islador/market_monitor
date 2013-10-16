# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  char_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

#Basic model for holding character IDs and Names for use in owner filtering on mis_show.
class Character < ActiveRecord::Base
  attr_accessible :char_id, :name

  belongs_to :user
  has_one :corporation
end
