FactoryGirl.define do
	factory :user do
		email "test@test.com"
		password "alphabetsoup"
		password_confirmation "alphabetsoup"
	end	
end