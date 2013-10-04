class ApisController < ApplicationController
  include ApiActiveChecker
  include CorpMarketOrders
  include CorpWalletTransactions
  include CharMarketOrders
  include CharWalletTransactions
	#before_filter :signed_in_user

  @@accessmasks = []
  @@accessmasks = [71307264, 10489856]

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
    api = Eve::API.new(:key_id => @api.key_id, :v_code => @api.v_code)
    result = api.account.apikeyinfo
    if @@accessmasks.include?(result.key.accessMask)
      @api.accessmask = result.key.accessMask
      if result.key.accessMask == @@accessmasks[0]
        @api.entity = 0
      else
        @api.entity = 1
      end
  	 if @api.save
      #Create a new cache times object to query if the key is active.
      @newActiveTimer = CacheTimes.new(user_id: current_user.id, api_id: @api.id, call_type: 1, cached_time: result.cachedUntil)
      @newActiveTimer.save

      #Create a new cache times object for corp market orders and wallet transactions.
      if @api.entity == 1
        @newCorpMarketOrdersTimer = CacheTimes.new(user_id: current_user.id, api_id: @api.id, call_type: 2, cached_time: DateTime.now)
        @newCorpMarketOrdersTimer.save

        @newCorpWalletTransactionsTimer = CacheTimes.new(user_id: current_user.id, api_id: @api.id, call_type: 3, cached_time: DateTime.now)
        @newCorpWalletTransactionsTimer.save
      end

      #Create a new cache times object for char market orders and wallet transactions.
      if @api.entity == 0
        @newCharMarketOrdersTimer = CacheTimes.new(user_id: current_user.id, api_id: @api.id, call_type: 4, cached_time: DateTime.now)
        @newCharMarketOrdersTimer.save

        @newCharWalletTransactionsTimer = CacheTimes.new(user_id: current_user.id, api_id: @api.id, call_type: 5, cached_time: DateTime.now)
        @newCharWalletTransactionsTimer.save
      end

  		flash[:success] = "Api #{@api.key_id} Created"
  		redirect_to apilist_path
  	 else
  		render 'new'
  	 end
    else
      flash[:error] = "You have not configured the API correctly."
      render 'new'
    end
  end

  def show
    if signed_in?
      #@apis = current_user.apis.paginate(page: params[:page]) #doesn't appear to be necessary.
      render 'api_list'
    else
      flash[:error] = "You must be signed in to view this page."
      redirect_to signin_path
    end
  end
end
