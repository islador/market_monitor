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
		accessmask 71307264
		active 1
		user

		factory :corporation do
			accessmask 10489856
			entity 1
		end
	end

	factory :cache_timer do
		cached_time DateTime.now
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

end