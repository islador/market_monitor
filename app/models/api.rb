# == Schema Information
#
# Table name: apis
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  type       :integer
#  key_id     :string(255)
#  v_code     :string(255)
#  accessmask :integer
#  active     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Api < ActiveRecord::Base
  attr_accessible :accessmask, :key_id, :type, :user_id, :v_code, :active
end
