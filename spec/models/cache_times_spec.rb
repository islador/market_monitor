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
	let(:user) {FactoryGirl.create(:user)}
	let(:api) {FactoryGirl.create(:api)}

	before do
		@time = CacheTimes.new(user_id: user.id, api_id: api.id, cached_time: DateTime.now, call_type: 1)
	end

	subject {@time}

	it {should be_valid}
	it {should respond_to(:user_id)}
	it {should respond_to(:api_id)}
	it {should respond_to(:cached_time)}
	it {should respond_to(:call_type)}
	it {should respond_to(:user)}
	it {should respond_to(:api)}

	describe "when user_id is not present" do
		before { @time.user_id = nil}
		it {should_not be_valid}
	end

	describe "when api_id is not present" do
		before { @time.api_id = nil }
		it { should_not be_valid}
	end

	describe "when cached_time is not present" do
		before { @time.cached_time = nil }
		it { should_not be_valid }
	end

	describe "when call_type is not present" do
		before { @time.call_type = nil }
		it { should_not be_valid }
	end
end
