# == Schema Information
#
# Table name: apis
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  type       :integer
#  key_id     :string(255)
#  v_code     :string(255)
#  accessmask :integer
#  active     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Api do
  let(:user) {FactoryGirl.create(:user)}
  #let(:api) {FactoryGirl.create(:character_api, user: user)}

  before do
  	@api = Api.new(type: 1, user_id: user.id, key_id: "123456789", v_code: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
	  	accessmask: 71307264, active: 1)
  end


  subject {@api}

  it {should respond_to(:type)}
  it {should respond_to(:key_id)}
  it {should respond_to(:v_code)}
  it {should respond_to(:accessmask)}
  it {should respond_to(:active)}

  it {should be_valid}

  describe "when user_id is not present" do
  	before { @api.user_id = nil}
  	it {should_not be_valid}
  end
end