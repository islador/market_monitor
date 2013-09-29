require 'spec_helper'

describe "UserPages" do

	subject {page}

	describe "signup page" do
		before {visit signup_path}

		it{should have_title(full_title('Sign Up'))}

		describe "to make an account" do
			it {should have_title(full_title('Sign Up'))}

			#fill_in "Email", with: "jack@jack.com"
			#fill_in "Password", with: "Jackolantern"
			#fill_in "Password Confirmation", with: "Jackolantern"
			#click_button "Register my Account"

			it "should redirect to user_path(user)" do
				should have_title(full_title('User Information'))
			end

		end

		describe "for non-signed-in users" do
			it{should have_selector('label',	text: 'Email')}
			it{should have_selector('label',	text: 'Password')}
			it{should have_selector('label',	text: 'Password Confirmation')}
		end

		describe "for signed-in users" do
			let(:user) {FactoryGirl.create(:user)}

			before do
				sign_in user
				visit signup_path
			end
			# they should be redirected to the account info page.
			it{should have_title(full_title('User Information'))}
			it{should have_selector('div.alert.alert-error',	text: 'Signed in users may not register new accounts.')}
		end
	end

	describe "user account page" do
		let(:user) {FactoryGirl.create(:user)}

		describe "for non-signed-in users" do
			
			it "should raise error" do
				expect {visit user_path(user)}.to raise_error(ActionController::RoutingError)
			end
		end

		describe "for signed-in users" do

			before do
				sign_in user
				visit user_path(user)
			end

			it {should have_title(full_title('User Information'))}
		end
	end

	describe "sign in page" do
		let(:user) {FactoryGirl.create(:user)}

		describe "for non-signed-in users" do
			before {visit signin_path}

			it {should have_title(full_title('Sign In'))}
			it {should have_selector('label', text: 'Email')}
			it {should have_selector('label', text: 'Password')}
		end

		describe "for signed-in users" do
			before do
				sign_in user
				visit signin_path
			end

			it "should redirect to the user's account page" do
				should have_title(full_title('User Information'))
			end
			it "should have flash" do
				should have_selector('div.alert.alert-error',	text: "You are already signed in.")
			end
		end
	end

	describe "help page" do
		let(:user) {FactoryGirl.create(:user)}

		describe "for non-signed-in users" do
			before {visit help_path}

			it {should have_title(full_title('Help'))}
		end

		describe "for signed-in users" do
			before do
				sign_in user
				visit help_path
			end

			it {should have_title(full_title('Help'))}
		end
	end

	describe "home page" do
		let(:user) {FactoryGirl.create(:user)}

		describe "for non-signed-in users" do
			before {visit root_path}

			it {should have_title(full_title(''))}
		end

		describe "for signed-in users" do
			before do
				sign_in user
				visit root_path
			end

			it {should have_title(full_title(''))}
		end
	end

	describe "market order overview page" do
		before {visit market_page_path}

		#it{should have_title(full_title('Market Order Overview'))}
		#order summaries total up and display averages of all orders of that item_id

		describe "detailed market order page" do

			#click on a specific item
			#
			#check that the title is Orders For item name, eg: Orders for Thoraxs
			#it{should have_title(full_title('Orders For:#{:item_name}'))}

			#should have each individual order for that item id listed.
			#each listed order contains exact information: purchase price, sale price, % markup, stock levels
		end
	end
end
