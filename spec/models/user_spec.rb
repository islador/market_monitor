# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  key_id          :string(255)
#  v_code          :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "Test", 
			email: "test@test.com", 
			key_id: "12345612",
			v_code: "301PBoCx11FGnc0qdtrEVnEcmhne5VZYbv4xG2e3HcMKwWQzUssoXdawcV6StwZn",
			password: "alphabetsoup",
			password_confirmation: "alphabetsoup")
	end

	subject {@user}

	it {should be_valid}
	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should respond_to(:key_id)}
	it {should respond_to(:v_code)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
end
