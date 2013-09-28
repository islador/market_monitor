require 'spec_helper'

describe "AuthenticationPages" do
  
  describe "sign in page" do
  	subject {page}

  	before {visit signin_path}

  	it {should have_title(full_title('Sign In'))}

  	describe "with invalid information" do
  		before {click_button "Sign In"}

  		it {should have_selector('div.alert.alert-error', text: 'Invalid')}
  	end

  	describe "with valid information" do
  		let(:user) {FactoryGirl.create(:user)}
  		before do
  			fill_in "Email", with: user.email
  			fill_in "Password", with: user.password
  			click_button "Sign In"
  		end

  		it {should have_title(full_title('User Information'))}
  	end
  end
end
