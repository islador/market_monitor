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

	#forcefully evaluated to ensure the user is active.
	let!(:user) {FactoryGirl.create(:user)}

	describe "should fire ApiActiveChecker" do
		#Force load a CacheTimes model for this test.
		let!(:timer) {FactoryGirl.create(:cache_times)}
		
		#Instantiate a copy of DummyClass to test the CacheTimers machinery.
		$derp = DummyClass.new
		it "should find call_type 1 and fire ApiActiveChecker.checkactive" do
			#Define which cassette to use to avoid testing CCP's APIs
			expect do
				VCR.use_cassette 'modules/api_active_checker' do
					#Call the method
					$derp.checktimes
				end
				#Test that ApiActiveChecker.checkactive builds a new CacheTimes model.
			end.not_to change(CacheTimes, :count)
			#Test that the CacheTimes model used was destroyed by CacheTimers.checktimes
			expect(CacheTimes.find_by_id(timer.id)).to be_nil
		end
	end

	describe "should fire CharMarketOrder" do
		let!(:corpordertimer) {FactoryGirl.create(:corpMarketOrder)}

		$derp = DummyClass.new
		it "should find call_type 2 and fire CharMarketOrder.input_orders" do
			expect do
				VCR.use_cassette 'modules/corp_market_order' do
					$derp.checktimes
				end
			end.not_to change(CacheTimes, :count)
			expect(CacheTimes.find_by_id(corpordertimer.id)).to be_nil
		end
	end

	describe "should fire CharMarketOrder" do
		let!(:charordertimer) {FactoryGirl.create(:charMarketOrder)}

		$derp = DummyClass.new
		it "should find call_type 4 and fire CharMarketOrder.input_char_orders" do
			expect do
				VCR.use_cassette 'modules/char_market_order' do
					$derp.checktimes
				end
			end.not_to change(CacheTimes, :count)
			expect(CacheTimes.find_by_id(charordertimer.id)).to be_nil
		end
	end
end