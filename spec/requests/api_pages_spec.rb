require 'spec_helper'

describe "APIPages" do 

	subject {page}

	describe "new-api page" do
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

			it {should have_title(full_title('Create new API'))}
			it {should have_selector('label', text: 'Key ID')}
			it {should have_selector('label', text: 'Verification Code')}
		end
	end
end