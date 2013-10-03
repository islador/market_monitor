class CacheTimes < ActiveRecord::Base
  attr_accessible :api_id, :cached_time, :call_type, :user_id
end
