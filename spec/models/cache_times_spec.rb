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
	before do
		@cachetime = CacheTimes.new(user_id: 1, api_id: 1, cached_time: DateTime.now, call_type: 1)
	end

	subject {@cachetime}

	it {should be_valid}
	it {should respond_to(:user_id)}
	it {should respond_to(:api_id)}
	it {should respond_to(:cached_time)}
	it {should respond_to(:call_type)}
end
