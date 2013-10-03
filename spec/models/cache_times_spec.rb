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

require 'spec_helper'

describe CacheTimes do
  pending "add some examples to (or delete) #{__FILE__}"
end
