require 'spec_helper'

describe "APIPages" do 

	subject {page}

	describe "newcharacterapi page" do
		let(:user) {FactoryGirl.create(:user)}

		describe "for non-signed-in users" do
			before {visit newcharacterapi_path}

			it "should redirect to the signin page" do
				should have_title(full_title('Sign In'))
			end
		end

		describe "for signed-in users" do
			before do
				sign_in user
				visit newcharacterapi_path
			end

			it {should have_title(full_title('Create new Character API'))}
			it {should have_selector('label', text: 'Key ID')}
			it {should have_selector('label', text: 'Verification Code')}
		end
	end

	describe "api list page" do
		let(:user) {FactoryGirl.create(:user)}
		let(:api) {FactoryGirl.create(:character_api, user: @user)}

		describe "for non-signed-in users" do
			before {visit apilist_path}

			it "should redirect to the signin page" do
				should have_title(full_title('Sign In'))
				should have_selector('div.alert.alert-error', text: "You must be signed in to view this page.")
			end
		end

		describe "for signed-in users" do
			before do
				sign_in user
				visit apilist_path
			end

			it {should have_title(full_title('API List'))}
		end
	end
end