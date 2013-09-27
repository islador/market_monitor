FactoryGirl.define do
	factory :user do
		email "test@test.com"
		key_id "1234567"
		v_code "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
		password "alphabetsoup"
		password_confirmation "alphabetsoup"
	end	
end