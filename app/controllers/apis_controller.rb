class ApisController < ApplicationController
  include ApiActiveChecker
  include CorpMarketOrders
  include CorpWalletTransactions
  include CharMarketOrders
  include CharWalletTransactions
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
    @accessmasks = [71307264, 10489864]
 
    @character_hash = {"char_id" => nil, "name" => nil}
    @corporation_hash = {"corp_id" => nil, "name" => nil}
    
    @api = current_user.apis.build(params[:api])
    api = Eve::API.new(:key_id => @api.key_id, :v_code => @api.v_code)
    result = api.account.apikeyinfo
    if @accessmasks.include?(result.key.accessMask)
      @api.accessmask = result.key.accessMask
      if result.key.accessMask == @accessmasks[0]
        @api.entity = 0
      else
        @api.entity = 1
      end
 
      #Call to character APIs to build character & corporation tables. This should probably be broken out into a separate method.
      character_call = api.account.characters
      character_call.characters.each do |c|
        #Extract the character IDs and Names from the API, storing them in a hash.
        
        @character_hash["char_id"] = c.characterID
        @character_hash["name"] = c.name
        @corporation_hash["corp_id"] = c.corporationID
        @corporation_hash["name"] = c.corporationName
 
        @character = current_user.characters.build(@character_hash)
        if @character.save
          @corporation = @character.build_corporation(@corporation_hash)
          @corporation.save
        end
      end
 
      #Set the API to Active since it provided an accessmask.
      @api.active = 1
      
      if @api.save
        #Create a new cache times object to query if the key is active.
        @newActiveTimer = CacheTimes.new(user_id: current_user.id, api_id: @api.id, call_type: 1, cached_time: result.cachedUntil)
        @newActiveTimer.save

        #Create a new outpost_builder CacheTimes only if there is not already one in existence.
        if CacheTimes.where('call_type = 6').empty?
          @new_outpost_builder_timer = CacheTimes.new(user_id: current_user.id, api_id: @api_id, call_type: 6, cached_time: DateTime.now)
          @new_outpost_builder_timer.save
        end
 
        #Create a new cache times object for corp market orders and wallet transactions.
        if @api.entity == 1
          @newCorpMarketOrdersTimer = CacheTimes.new(user_id: current_user.id, api_id: @api.id, call_type: 2, cached_time: DateTime.now)
          @newCorpMarketOrdersTimer.save

          #query the corporation_sheet API
          corp_sheet = api.corporation.corporation_sheet
          #build a hash to update the existing corporation object iwth
          division_hash = {:wallet_0 => nil, :wallet_1 => nil, :wallet_2 => nil, :wallet_3 => nil, :wallet_4 => nil, :wallet_5 => nil, :wallet_6 => nil}
          division_hash[:wallet_0] = "Master"
          division_hash[:wallet_1] = corp_sheet.wallet_divisions[1].description
          division_hash[:wallet_2] = corp_sheet.wallet_divisions[2].description
          division_hash[:wallet_3] = corp_sheet.wallet_divisions[3].description
          division_hash[:wallet_4] = corp_sheet.wallet_divisions[4].description
          division_hash[:wallet_5] = corp_sheet.wallet_divisions[5].description
          division_hash[:wallet_6] = corp_sheet.wallet_divisions[6].description
          #update the corporation object. update_attributes saves the record.
          @corporation.update_attributes(division_hash)

          #update the api record with the corporation id, this way wallets may be easily retrieved.
          @api.update_attributes(:corporation_id => @corporation.id)
 
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

  def wallet_settings()
    @corp = Corporation.where("id = ?", Api.where("id = ?", params[:api_id])[0].corporation_id)[0]

    respond_to do |format|
      format.js
    end 
  end
end