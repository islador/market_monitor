require 'spec_helper'

describe "APIPages" do 

	subject {page}

	describe "newcharacterapi page" do
		let(:user) {FactoryGirl.create(:user)}

		describe "non-signed-in users" do
			before {visit newcharacterapi_path}

			it "should redirect to the signin page" do
				should have_title(full_title('Sign In'))
			end
		end

		describe "signed-in users" do
			before do
				sign_in user
				visit newcharacterapi_path
			end

			it {should have_title(full_title('Enroll new Character API'))}
			#it {should have_selector('label', text: 'Key ID')}
			#it {should have_selector('label', text: 'Verification Code')}
		end
	end

	describe "newcorporationapi page" do
		let(:user) {FactoryGirl.create(:user)}

		describe "non-signed-in users" do
			before {visit newcorporationapi_path}

			it "should redirect to the signin page" do
				should have_title(full_title('Sign In'))
			end
		end

		describe "signed-in users" do
			before do
				sign_in user
				visit newcorporationapi_path
			end

			it {should have_title(full_title('Enroll new Corporation API'))}

			describe "should be able to enroll APIs" do
				before do
					fill_in 'Key ID', with: "123456789"
					fill_in "Verification Code",	with: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
					click_button "Submit New Key"
				end
				it "should redirect to the api list" do
					should have_title(full_title('API List'))
				end
			end
		end
	end

	describe "api list page" do
		let(:user) {FactoryGirl.create(:user)}
		#let(:api) {FactoryGirl.create(:api, user: user)}

		describe "non-signed-in users" do
			before {visit apilist_path}

			it "should redirect to the signin page" do
				should have_title(full_title('Sign In'))
				should have_selector('div.alert.alert-error', text: "You must be signed in to view this page.")
			end
		end

		describe "signed-in users" do
			before do
				sign_in user
				#visit newcharacterapi_path

				#fill_in 'Key ID', with: "123456789"
				#fill_in "Verification Code",	with: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
				#click_button "Submit New Key"
				FactoryGirl.create(:corporation, user: user)
				visit apilist_path
			end

			it {should have_title(full_title('API List'))}
			#it {should have_selector('span.KeyID', text: "123456789")}
			it {should have_selector('h3', text: "APIs (1)")}
			#it {should have_content('Key ID')}
		end
	end
end