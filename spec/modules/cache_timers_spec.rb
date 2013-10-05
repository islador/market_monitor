require 'spec_helper'

# call_type translations
# | Code | Translation |
# |:----:|:-----------:|
# | 1 | Api Status |
# | 2 | Corp Market Order |
# | 3 | Corp Wallet Transactions |
# | 4 | Character Market Order |
# | 5 | Character Wallet Transactions |

describe "CacheTimers" do

	#Create a dummy class for use in testing cache_timers.
	class DummyClass
		include CacheTimers
		def checktimes
			CacheTimers.checktimes
		end
	end

	#forcefully evaluated to ensure the models are active.
	let!(:user) {FactoryGirl.create(:user)}
	let!(:api) {FactoryGirl.create(:api)}
	let!(:timer) {FactoryGirl.create(:cache_times)}

	describe "CacheTimers.checktimes" do
		$derp = DummyClass.new

		it "ApiActiveChecker.checkactive should fire" do
			expect($derp.checktimes).not_to change(CacheTimes, :count)
			expect(timer.id).to be_nil
		end
	end

	describe "CacheTimers should fire CorpMarketOrder" do
		let!(:corporder) {FactoryGirl.create(:corpMarketOrder)}
		it "should find call_type 2 and fire CorpMarketOrder.input_orders" do
			#@dummy
			#expect {@dummy}.not_to change(CacheTimes, :count)
			#expect{corporder.id}.to be_nil
		end
	end

end