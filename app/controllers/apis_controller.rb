class ApisController < ApplicationController
	#before_filter :signed_in_user

  def new
  	if signed_in?
  		@api = current_user.apis.build
  	else
  		flash[:error] = "You must be signed in to create an API."
  		redirect_to signin_path
  	end
  end

  def create
  	@api = current_user.apis.build(params[:api])
  	if @api.save
  		flash[:success] = "Api #{@api.key_id} Created"
  		redirect_to user_path(current_user)
  	else
  		render 'new'
  	end
  end
end
