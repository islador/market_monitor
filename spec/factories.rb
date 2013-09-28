FactoryGirl.define do
	factory :user do
		sequence(:email) {|n| "email#{n}@test.com"}
		password "alphabetsoup"
		password_confirmation "alphabetsoup"
	end

	factory :character_api do
		type 0
		sequence(:key_id) {|n| "#{n}234789"}
		v_code "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
		accessmask 71307264
		active 1
		user
	end

	factory :corporation_api do
		type 1
		equence(:key_id) {|n| "#{n}234789"}
		v_code "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
		accessmask 10489856
		active 1
		user
	end
end