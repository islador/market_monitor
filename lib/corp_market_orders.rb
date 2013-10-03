module CorpMarketOrders
	def update(id)

		#Assemble a hash for use in updating existing orders.
		@updatehash = {"vol_remaining" => nil, "order_state" => nil, "escrow" => nil, "price" => nil}

		#Extract the active status from the database.
		@active = Api.find_by_id(id)

		#Check for activity to ensure dead APIs aren't hammered.
		if @active == 1

			#Assemble the API for the EVE Gem.
			api = Eve::API.new(:key_id => Api.find_by_id(id).key_id, :v_code => Api.find_by_id(id).v_code)

			#Load Characters to retrieve character IDs
			result = api.account.characters

			#select the user from the API assocation
			@user = User.find_by_id(Api.find_by_id(id).user_id)
				
			# Build and make the API Call
			api.set( :character_id => result.characters[0].character_id)
			result = api.corporation.market_orders

			
			#pull the API ID out of the @apilist variable before looping.

			#Iterate through each returnd order.
			result.each do |o|

				#load the hash with the variables that change from query to query.
				@updatehash["vol_remaining"] = o.volRemaining
				@updatehash["order_state"] = o.orderState
				@updatehash["escrow"] = o.escrow
				@updatehash["price"] = o.price

				#Update the existing order.
				MarketOrder.find_by_order_id(o.orderID).update_attributes(@updatehash)
			end
		end
	end

	def input_orders(id)
		#Assemble a hash for use in inserting into the database.
		@temphash = {"user_id" => nil, "api_id" => nil, "market_summary_id" => nil, "order_id" => nil, "char_id" => nil, "station_id" => nil, "vol_entered" => nil, "vol_remaining" => nil, "min_volume" => nil, "order_state" => nil, "type_id" => nil, "reach" => nil, "account_key" => nil, "duration" => nil, "escrow" => nil, "price" => nil, "bid" => nil, "issued" => nil }
		#Extract the active status from the database.
		@active = Api.find_by_id(id)

		#Check for activity to ensure dead APIs aren't hammered.
		if @active == 1

			#Assemble the API for the EVE Gem.
			api = Eve::API.new(:key_id => Api.find_by_id(id).key_id, :v_code => Api.find_by_id(id).v_code)

			#Load Characters to retrieve character IDs
			result = api.account.characters

			#select the user from the API assocation
			@user = User.find_by_id(Api.find_by_id(id).user_id)
				
			# Build and make the API Call
			api.set( :character_id => result.characters[0].character_id)
			result = api.corporation.market_orders

			#set the api_id before looping as it is static.
					@temphash["api_id"] = id 

			#Iterate through each returnd order.
			result.each do |o|
				#Check for existing order, if found, execute the update method.
				if MarketOrder.find_by_order_id(o.orderID) != nil
					update(id)			
				else
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
					@user.market_orders.build(@temphash)
				end
			end
		end
	end
end