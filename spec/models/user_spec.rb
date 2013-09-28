# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "Test", 
			email: "test@test.com", 
			password: "alphabetsoup",
			password_confirmation: "alphabetsoup")
	end

	subject {@user}

	it {should be_valid}
	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:remember_token)}
	it {should respond_to(:authenticate)}

	describe "remember token" do
		before {@user.save}
		its(:remember_token) {should_not be_blank}
	end
end
