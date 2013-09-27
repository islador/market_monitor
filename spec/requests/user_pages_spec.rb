require 'spec_helper'

describe "UserPages" do

	subject {page}

	describe "signup page" do
		before {visit signup_path}

		it{should have_title(full_title('Sign Up'))}

		#it { should have_selector('title', :text 'Sign Up') }
		
	end

	describe "market order overview page" do
		before {visit market_page_path}

		it{should have_title(full_title('Market Order Overview'))}
		#order summaries total up and display averages of all orders of that item_id

		describe "detailed market order page" do

			#click on a specific item
			#
			#check that the title is Orders For item name, eg: Orders for Thoraxs
			it{should have_title(full_title('Orders For:#{:item_name}'))}

			#should have each individual order for that item id listed.
			#each listed order contains exact information: purchase price, sale price, % markup, stock levels
		end
	end
end
