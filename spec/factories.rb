FactoryGirl.define do
	
	factory :user do
		sequence(:email) {|n| "email#{n}@test.com"}
		password "alphabetsoup"
		password_confirmation "alphabetsoup"
	end

	factory :api do
		entity 0
		sequence(:key_id) {|n| "#{n}234789"}
		v_code "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
		#Modified to create cassettes for testing.
		#key_id "2638835"
		#v_code "HGo53iK9v7nPHJ1rTMsNYBiQ4JISjP1vR2rM44KNNj4wAcVtNIJnWaWmeWheFuSo"
		#second cassette API
		#key_id "2638832"
		#v_code "rFhvKwpQnuVkIj0BmB8vgyYssR760i7a1pcTxxr4TPIlEiTwj8xXMRyAWpQsJ6Zi"
		accessmask 71307264
		active 1
		user

		factory :corporation do
			accessmask 10489856
			entity 1
		end
	end

	factory :cache_times do
		cached_time DateTime.now #This forces any cache timers generated to immediately trigger the CacheTimers machinery.
		call_type 1
		user
		api

		factory :corpMarketOrder do
			call_type 2
		end

		factory :corpWalletTransactions do
			call_type 3
		end

		factory :charMarketOrder do
			call_type 4
		end

		factory :charWalletTransactions do
			call_type 5
		end
	end

	#Example Call
	# FactoryGirl.create(:market_order, :set_state => 1, :set_key => 1005, :set_station => rand(1000..1010), :set_type => rand(1000..1010), :set_char => rand(1000..1010))
	# FactoryGirl.create(:market_order, user: <user object>, api: <api object>) # uses the objects passed in to build the MarketOrder.
	# Defaults to the set_state/key values.
	factory :market_order do
		ignore do
			set_state 0 #possible values => 0, 1, 2, 3
			set_key 1000 #possible values => 1000, 1001, 1002, 1003, 1004, 1005, 1006
			set_station 1000 #Accepts any value, suggested: rand(1000..1010)
			set_type 1000 #Accepts any value, suggested: rand(1000..1010)
			set_char 1000 #Accepts any value, suggested: rand(1000..1010)
		end
		#Must be unique.
		sequence(:order_id) {|n| n}

		#Dynamic, but limited values needed for MarketItemSummaries testing.
		order_state {set_state}
		account_key {set_key} 

		#Moderate - Light duplication necessary for MarketItemSummaries testing.
		station_id {set_station} #When combo'd with rand advice, allows for predictable collisions.
		type_id {set_type} 
		char_id {set_char}

		#Fixed or sequenced values acceptable for all testing.
		sequence (:vol_entered) {|n| n}
		sequence(:vol_remaining) {|n| n}
		min_volume 1
		reach 32767
		duration 84
		escrow nil
		sequence(:price, (12345.11..98765.99).step(0.1).to_enum) {|n| n}
		bid false
		issued DateTime.now
		
		# Creates a new model unless one is passed in.
		user
		api

		factory :buy_order do
			bid true
			sequence(:escrow, (12345.11..98765.99).step(0.1).to_enum) {|n| n}
		end

	end
end