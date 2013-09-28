FactoryGirl.define do
	factory :user do
		email "test@test.com"
		password "alphabetsoup"
		password_confirmation "alphabetsoup"
	end

	factory :character_api do
		type 0
		key_id "12346789"
		v_code "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
		accessmask 71307264
		active 1
		user
	end

	factory :corporation_api do
		type 1
		key_id "123456789"
		v_code "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
		accessmask 10489856
		active 1
		user
	end
end