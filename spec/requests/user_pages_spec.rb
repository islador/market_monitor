require 'spec_helper'

describe "UserPages" do

	subject {page}

	describe "signup page" do
		before {visit signup_path}

		it{should have_title(full_title('Sign Up'))}

		describe "for non-signed-in users" do
			it{should have_selector('label',	text: 'Email')}
			#it{should have_selector('label',	text: 'Key ID')}
			#it{should have_selector('label',	text: 'Verification Code')}
			it{should have_selector('label',	text: 'Password')}
			it{should have_selector('label',	text: 'Password Confirmation')}
		end

		describe "for signed-in users" do
			let(:user) {FactoryGirl.create(:user)}

			before do
				sign_in user
				visit signup_path
			end

			it{should have_title(full_title('User Information'))}
			it{should have_selector('div.alert.alert-error',	text: 'Signed in users may not register new accounts.')}
		end
	end

	describe "user pages" do
		let(:user) {FactoryGirl.create(:user)}

		before do
			sign_in user
			visit user_path(user)
		end

		it {should have_title(full_title('User Information'))}

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
