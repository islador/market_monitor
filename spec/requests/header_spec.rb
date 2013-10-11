require 'spec_helper'

describe "HeaderPages" do

	subject {page}

	describe "link tests" do
		let(:user) {FactoryGirl.create(:user)}

		before{visit root_path}

		it {should have_title(full_title(''))}

		describe "as signed in user" do
			before do
				sign_in user
				visit root_path
			end

			it {should have_link('Sign Out')}
			it {should have_link('Edit Account')}
			it {should have_link('APIs')}
			it {should have_link('Enroll new Api')}
			it {should have_link('API List')}
			it {should have_link('Item Order Summaries')}

		end

		describe "as non-signed-in user" do
			
			it {should have_link('Sign In')}
			it {should have_link('Sign Up')}
		end
	end
end