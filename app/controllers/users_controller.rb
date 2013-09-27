class UsersController < ApplicationController
  def new
  	@user = User.new
  	# Require email, key_id, v_code, password, password confirmation
  	# Parse API, have user select main character
  	# Use selected character to fill in name attribute on model
  end

  def create
  	
  end

  def show
  	@user = User.find(params[:id])
  	# Display user account page.
  	# Allows editing of all attributes except email.
  	# Displays a list of which APIs are accessible to the application.
  end
end
