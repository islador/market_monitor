# == Schema Information
#
# Table name: apis
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  entity     :integer
#  key_id     :string(255)
#  v_code     :string(255)
#  accessmask :integer
#  active     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# API to Model Map
# | API | Model | Reason |
# |:---:|:-----:|:------:|
# | Key ID | key_id | |
# | Verification Code | v_code | |
# | Access Mask | accessmask | |
# | | entity | Set to 1 for corporation, 0 for character, infered at time of enrollment by the access mask. |
# | | active | Whether the API returned data on the last query. |

class Api < ActiveRecord::Base
  attr_accessible :accessmask, :key_id, :entity, :v_code, :active

  belongs_to :user


  validates :user_id, presence: true
  validates :key_id, presence: true, uniqueness: true
  validates :v_code, presence: true, length: {minimum: 64}
  #validates :accessmask, presence: true, numericality: { only_integer: true }
end
