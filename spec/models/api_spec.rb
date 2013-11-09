# == Schema Information
#
# Table name: apis
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  entity         :integer
#  key_id         :string(255)
#  v_code         :string(255)
#  accessmask     :integer
#  active         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  wallet_id      :string(255)
#  corporation_id :integer
#

require 'spec_helper'

describe Api do
  let(:user) {FactoryGirl.create(:user)}
  #let(:api) {FactoryGirl.create(:character_api, user: user)}

  before do
  	@api = user.apis.build(entity: 1, key_id: "123456789", v_code: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
	  	accessmask: 71307264, active: 1)
  	#@api = Api.new(type: 1, user_id: user.id, key_id: "123456789", v_code: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
	#  	accessmask: 71307264, active: 1)
  end


  subject {@api}
  #subject {api}

  it {should respond_to(:entity)}
  it {should respond_to(:key_id)}
  it {should respond_to(:v_code)}
  it {should respond_to(:accessmask)}
  it {should respond_to(:active)}
  it {should respond_to(:user_id)}
  it {should respond_to(:user)}

  its(:user) {should == user}

  it {should be_valid}

  describe "when user_id is not present" do
  	before { @api.user_id = nil}
  	it {should_not be_valid}
  end

  describe "when key_id is not present" do
    before {@api.key_id = nil}
    it {should_not be_valid}
  end

  describe "when v_code is not present" do
    before {@api.v_code = nil}
    it {should_not be_valid}
  end

  describe "when accessmask is not present" do
    before {@api.accessmask = nil}
    it {should_not be_valid}
  end

  describe "accessible attributes" do
  	it "should not allow access to user_id" do
  		expect do
  			Api.new(user_id: user.id)
  		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end
end
