require 'spec_helper'

describe "Item Order Summary Pages" do
	subject { page }

	describe "Item Order Summary Page" do

		#Build a character, api, 2x market orders
		let(:user) {FactoryGirl.create(:user)}
		let(:api) {Factorygirl.create(:api, user: user)}
		let(:mo1) {FactoryGirl.create(:market_order, user: user, api: api, :set_station => 2, :set_type => 1, :set_char => 3)}
		let(:mo2) {FactoryGirl.create(:market_order, user: user, api: api, :set_station => 2, :set_type => 1, :set_char => 3)}

		#Build a MIS

		describe "for signed-in users" do
			before do
				sign_in user
				visit marketsummaries_path
			end

			describe "there should be four filter drop downs" do
				it {should have_selector('select.station_select', text: 'All Stations')}
				it {should have_selector('select.listing_character', text: 'All Characters')}
				it {should have_selector('select.owner', text: 'All Owners')}
				it {should have_selector('select.type', text: 'Buy/Sell')}
			end
		end

		describe "for non-signed-in users" do
			before {visit marketsummaries_path}

			it "should redirect to the sign_in page" do
				should have_title(full_title('Sign In'))
				should have_selector('div.alert.alert-error', text: "You must be signed in to view this page.")
			end
		end
	end
end 