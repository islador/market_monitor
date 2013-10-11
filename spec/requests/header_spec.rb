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
			it {should have_link('Enroll new API')}
			it {should have_link('API List')}
			it {should have_link('Item Order Summaries')}

			describe "Item Order Summaries link" do
				before do
					click_link('Item Order Summaries')
				end
				it {should have_title(full_title('Item Order Summaries'))}
			end

			describe "API List link" do
				before do
					click_link('API List')
				end
				it {should have_title(full_title('API List'))}
			end

			describe "Enroll new API link" do
				before do
					click_link('Enroll new API')
				end
				it {should have_title(full_title('Enroll new API'))}
			end

			describe "Sign Out link" do
				before do
					click_link('Sign Out')
				end
				it {should have_title(full_title(''))}
			end
		end

		describe "as non-signed-in user" do
			
			it {should have_link('Sign In')}
			it {should have_link('Sign Up')}
		end
	end
end