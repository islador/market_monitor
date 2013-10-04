module CorpMarketOrders
	def self.update(api_id)

		#Assemble a hash for use in updating existing orders.
		@updatehash = {"vol_remaining" => nil, "order_state" => nil, "escrow" => nil, "price" => nil}
		puts "Called update method"
		#Extract the active status from the database.
		@active = Api.find_by_id(api_id)

		#Check for activity to ensure dead APIs aren't hammered.
		if @active == 1

			#Assemble the API for the EVE Gem.
			api = Eve::API.new(:key_id => Api.find_by_id(api_id).key_id, :v_code => Api.find_by_id(api_id).v_code)

			#Load Characters to retrieve character IDs
			result = api.account.characters

			#select the user from the API assocation
			@user = User.find_by_id(Api.find_by_id(api_id).user_id)
				
			# Build and make the API Call
			api.set( :character_id => result.characters[0].character_id)
			result = api.corporation.market_orders

			
			#pull the API ID out of the @apilist variable before looping.

			#Iterate through each returnd order.
			result.orders.each do |o|

				#load the hash with the variables that change from query to query.
				@updatehash["vol_remaining"] = o.volRemaining
				@updatehash["order_state"] = o.orderState
				@updatehash["escrow"] = o.escrow
				@updatehash["price"] = o.price

				#Update the existing order.
				MarketOrder.find_by_order_id(o.orderID).update_attributes(@updatehash)
			end
			@newTimer = CacheTime.new(user_id: @user.id, api_id: api_id, cached_time: result.cachedUntil, call_type: 2)
			@new.save
		end
		puts "finished update method"
	end

	def self.input_orders(api_id,cache_time_id)
		#Assemble a hash for use in inserting into the database.
		@temphash = {"user_id" => nil, "api_id" => nil, "market_summary_id" => nil, "order_id" => nil, "char_id" => nil, "station_id" => nil, "vol_entered" => nil, "vol_remaining" => nil, "min_volume" => nil, "order_state" => nil, "type_id" => nil, "reach" => nil, "account_key" => nil, "duration" => nil, "escrow" => nil, "price" => nil, "bid" => nil, "issued" => nil }
		puts "Built temphash CorpMarketOrders.input_orders(id)"
		#Extract the active status from the database.
		@active = Api.find_by_id(api_id).active
		puts "Built active variable."

		#Check for activity to ensure dead APIs aren't hammered.
		if @active == 1
			puts "Passed active test."

			#Assemble the API for the EVE Gem.
			api = Eve::API.new(:key_id => Api.find_by_id(api_id).key_id, :v_code => Api.find_by_id(api_id).v_code)
			puts "Assembled API"

			#Load Characters to retrieve character IDs
			result = api.account.characters
			puts "loaded Characters"

			#select the user from the API assocation
			@user = User.find_by_id(Api.find_by_id(api_id).user_id)
			puts "Selected user from the API association."
				
			# Build and make the API Call
			api.set( :character_id => result.characters[0].character_id)
			result = api.corporation.market_orders
			puts "Built and made the API call to corporation.market_orders."

			#set the api_id before looping as it is static.
			@temphash["api_id"] = api_id 
			puts "set the temphash api_id variable."

			#Iterate through each returnd order.
			result.orders.each do |o|
				#Check for existing order, if found, execute the update method.
				if MarketOrder.find_by_order_id(o.orderID) != nil
					update(api_id)			
				else
					puts "Creating a new order."
					#Load each order attribute into a hash for easy database insertion.
					@temphash["order_id"] = o.orderID
					@temphash["char_id"] = o.charID
					@temphash["station_id"] = o.stationID
					@temphash["vol_entered"] = o.volEntered
					@temphash["vol_remaining"] = o.volRemaining
					@temphash["min_volume"] = o.minVolume
					@temphash["order_state"] = o.orderState
					@temphash["type_id"] = o.typeID
					@temphash["reach"] = o.range
					@temphash["account_key"] = o.accountKey
					@temphash["duration"] = o.duration
					@temphash["escrow"] = o.escrow
					@temphash["price"] = o.price
					@temphash["bid"] = o.bid
					@temphash["issued"] = o.issued

					#Insert into the database
					@order = @user.market_orders.build(@temphash)
					@order.save
					puts "Saved @order."
				end
			end
			#Create and save a new CacheTimes model based on the cachedUntil datetime 
			#returned by the API pulled in this invocation. This is executed regardless
			#of whether a new order is created or an existing order is updated.
			@newTimer = CacheTimes.new(user_id: @user.id, api_id: api_id, call_type: 2, cached_time: result.cachedUntil)
			puts @newTimer
			@newTimer.save
		end

		#Delete the CacheTimes model that caused this method to be invoked.
		#This is called outside of the API's active check, so the first time an
		#API is called after being inactive, it is deleted.
		CacheTimes.delete(cache_time_id)
		puts "Finished executing CorpMarketOrders.input_orders."
	end
end