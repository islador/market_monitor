module CorpMarketOrders
	def Update(id)
		@api = id #

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
end