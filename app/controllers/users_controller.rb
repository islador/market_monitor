class UsersController < ApplicationController
	before_filter :correct_user, only: [:show]

  def new
  	if signed_in?
  		flash[:error] = "Signed in users may not register new accounts."
  		redirect_to user_path(current_user)
  	else
  		@user = User.new
  	end
  	# Require email, key_id, v_code, password, password confirmation
  	# Parse API, have user select main character
  	# Use selected character to fill in name attribute on model
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		flash[:success] = "Registration Successful"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def show
  	if signed_in?
  		@user = User.find(params[:id])
  	end
  	# Display user account page.
  	# Allows editing of all attributes except email.
  	# Displays a list of which APIs are accessible to the application.
  end

  private

  def correct_user
      @user = User.find(params[:id])
      redirect_to(not_found) unless current_user?(@user)
    end
end
