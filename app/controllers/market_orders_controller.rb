class MarketOrdersController < ApplicationController

	# Populate serves to fill the database with market orders.
	def populate
		@apilist = Api.pluck(:id) #assemble an array to iterate through

		#Increment through the array loading each API's data into the database.
		@apilist.each do |n|

			#Extract the active status and entity type from the database.
			@active = Api.find_by_id(n).active 
			@entity = Api.find_by_id(n).entity

			#Check for activity to ensure dead APIs aren't hammered.
			if @active == 1 {

				#Assemble the API for the EVE Gem.
				api = Eve::API.new(:key_id => Api.find_by_id(n).key_id, :v_code => Api.find_by_id(n).v_code)

				#Load Characters to retrieve character IDs
				result = api.account.characters

				#Branch for corp vs character APIs
				if @entity ==1

					# Build and make the API Call
					api.set( :character_id => result.characters[0].character_id)
					result = api.corporation.market_orders

					#Load into a hash for mapping to the database keys. check demo.rb.
					#Sort a way to update an EXISTING order based on order ID.
					#Maybe run an index on order IDs, then compare the order IDs?
					#When you find one that matches, over write with the new data?
					# Oooh! Break it out into a separate method, call it update or something.

					#Find a way to DRY up the character/corporation branch?
				else
					#Iterate through each character accessible on the API
					result.characters.each do |c|

						#Build and make the API Call
						api.set( :character_id => result.characters[c].character_id)
						result = api.character.market_orders

			}
	    end
	end
end
