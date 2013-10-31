class MarketItemSummariesController < ApplicationController
	def show
		if signed_in?
	      #@apis = current_user.apis.paginate(page: params[:page]) #doesn't appear to be necessary.
	      render 'show_msi'
	      #@mis = MarketItemSummary.where('user_id = ?', user_id)
	    else
	      flash[:error] = "You must be signed in to view this page."
	      redirect_to signin_path
	    end
	end

	def filter()
		@input = params[:data]
		flash[:error] = "nice ajax bro"
	end
end
