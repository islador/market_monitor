# == Schema Information
#
# Table name: cache_times
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  api_id      :integer
#  cached_time :datetime
#  call_type   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# call_type translations
# | Code | Translation |
# |:----:|:-----------:|
# | 1 | Api Status |
# | 2 | Corp Market Order |
# | 3 | Corp Wallet Transactions |
# | 4 | Character Market Order |
# | 5 | Character Wallet Transactions |

class CacheTimes < ActiveRecord::Base
  attr_accessible :api_id, :cached_time, :call_type, :user_id
  
end
