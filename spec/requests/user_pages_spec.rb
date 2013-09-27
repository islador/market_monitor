require 'spec_helper'

describe "UserPages" do

	subject {page}

	describe "signup page" do
		before {visit signup_path}

		it{should have_selector('title', text: 'Sign Up')}

		#it { should have_selector('title', :text 'Sign Up') }
		
	end
end
