module MISBuilder

	def self.prepdb
		#This code is intended for testing purposes only.
		#This code can be used in specs to make testing this MUCH easier. It may even be duplicable into cache_timers.
		#Start by deleting anything in the database.
		User.destroy_all
		puts "Destroyed all Users"
		Api.destroy_all
		puts "Destroyed all APIs"
		MarketOrder.destroy_all
		puts "Destroyed all MOs"
		MarketItemSummary.destroy_all
		puts "Destroyed all MISs"
		Character.destroy_all
		puts "Destroyed all Characters"
		Corporation.destroy_all
		puts "Destroyed all Corporations"

		#Then create two new users
		@@user1 = FactoryGirl.create(:user)
		@@user2 = FactoryGirl.create(:user)
		puts "Built users"

		#Add APIs
		@@api1 = FactoryGirl.create(:api, user: @@user1)
		@@api2 = FactoryGirl.create(:api, user: @@user2)
		@@corpapi1 = FactoryGirl.create(:corp_api, user: @@user1)
		@@corpapi2 = FactoryGirl.create(:corp_api, user: @@user2)
		puts "Built APIs"

		#Add Characters
		@@character1 = FactoryGirl.create(:character, user: @@user1)
		@@character2 = FactoryGirl.create(:character, user: @@user1)
		@@character3 = FactoryGirl.create(:character, user: @@user1)
		puts "Built Characters"

		#Add Corporations
		@@corporation1 = FactoryGirl.create(:corporation, character: @@character1)
		@@corporation2 = FactoryGirl.create(:corporation, character: @@character2)
		@@corporation3 = FactoryGirl.create(:corporation, character: @@character3)
		puts "Built Corporations"

		#Add Market Orders
		#100 orders for each user, 50 for each API.
		50.times{FactoryGirl.create(:market_order, user: @@user1, api: @@api1, :set_station => 60000013, :set_type => rand(1000..1010), :set_char => @@character1.char_id)}
		puts "Built out 50 MOs for User1 Api1 and Character: " + @@character1.name + " (" + @@character1.char_id.to_s + ")"

		50.times{FactoryGirl.create(:market_order, user: @@user1, api: @@corpapi1, :set_station => 60000025, :set_type => rand(1000..1010), :set_char => @@character2.char_id)}
		puts "Built out 50 MOs for User1 CorpApi1 and Character: " + @@character2.name + " (" + @@character2.char_id.to_s + ")"

		50.times{FactoryGirl.create(:market_order, user: @@user2, api: @@api2, :set_station => rand(1000..1002), :set_type => rand(1000..1010), :set_char => 600750)}
		puts "Built out 50 MOs for User2 Api2"

		50.times{FactoryGirl.create(:market_order, user: @@user2, api: @@corpapi2, :set_station => rand(1000..1002), :set_type => rand(1000..1010), :set_char => 600750)}
		puts "Built out 50 MOs for User2 CorpApi2"

		build(@@user1.id)
		puts "Build complete."
	end

	def self.build(user_id)
		#Trigger: CacheTimers.checktimes call_type 2 & call_type 4

		#It is faster to do single large multi-row inserts rather then multiple single row inserts. the rails ORM may handle this
		#for me, do some research, then keep this in mind for refactoring.
		#Source: http://stackoverflow.com/questions/1793169/which-is-faster-multiple-single-inserts-or-one-multiple-row-insert

		
		#Assemble a hash for use in building new MIS
		temphash = {"type_id" => nil, "station_id" => nil, "char_id" => nil, "entity" => nil, "bid" => nil}
		#Assemble the user and apilist arrays.
		user = User.where('id = ?', user_id)
		apilist = Api.where('user_id = ?', user_id)

		#Iterate through each API.
		apilist.each do |api|
			#Set the API's entity value.
			temphash["entity"] = api.entity
			#Query for orders that are not in a MIS but belong to the current API and User.
			returned_orders = MarketOrder.where('user_id = :userid AND api_id = :apiid AND market_item_summary_id IS NULL', {userid: user_id, apiid: api.id})
			#Iterate through each returned order.
			returned_orders.each do |ro|
				#Query for any MIS that match the current order.
				mis = MarketItemSummary.where('user_id = :userid AND entity = :entity AND type_id = :mo_type_id AND station_id = :mo_station_id AND char_id = :mo_char_id AND bid = :mo_bid', {userid: user_id, entity: api.entity, mo_type_id: ro.type_id, mo_station_id: ro.station_id, mo_char_id: ro.char_id, mo_bid: ro.bid})

				#Check if an empty array is returned or if it contains a model.
				if mis.empty?
					#if it does not contain a model query for the order.
					#this is done because I am unsure how the index will behave if I use the ro instead of a new variable.
					order = MarketOrder.where('id = ?', ro.id)

					#assemble a hash
					temphash["type_id"] = order[0].type_id
					temphash["station_id"] = order[0].station_id
					temphash["char_id"] = order[0].char_id
					temphash["bid"] = order[0].bid

					#build a new MIS
					new_mis = user[0].market_item_summaries.build(temphash)
					new_mis.save

					#and associate the order with the MIS.
					order[0].market_item_summary_id = new_mis.id
					order[0].save
					calculate_averages(user[0].id, new_mis.id)
					puts "Saved new_mis: " + new_mis.id.to_s + ", order_id: " + order[0].id.to_s + ", user_id: " + user[0].id.to_s
				else
					#If it contains a model, associate the MO with the matching MIS.
					order = MarketOrder.where('id = ?', ro.id)

					#Assumes mis only ever returns a single item.
					order[0].market_item_summary_id = mis[0].id
					order[0].save
					puts "Updated existing MIS: " + mis[0].id.to_s + ", user_id: " + user[0].id.to_s
					calculate_averages(user[0].id, mis[0].id)
				end
			end
		end
	end

	def self.calculate_averages(user_id, market_item_summary_id)
		##########
		#This entire method can be optimized by returning the values instead of iniating another save. It is very likely that any method calling this one would be in the process of creating, updating or otherwise need to save the MIS.
		##########

		#Query for the MIS and store it in a local array.
		mis = MarketItemSummary.where('id = ?', market_item_summary_id)

		#Use an average aggregate function to calculate and extract the average sale price of all active orders associated with the MIS.
		asp = MarketOrder.select('avg(price) as price').where('market_item_summary_id = ? AND order_state = 0', market_item_summary_id)[0].price.to_f
		#Use a total aggregate function to calculate and extract the total volume entered of all active orders associated with the MIS.
		tve = MarketOrder.select('total(vol_entered) as vol_entered').where('market_item_summary_id = ? AND order_state = 0', market_item_summary_id)[0].vol_entered
		#Use a total aggregate function to calculate and extract the total volume remaining of all active orders associated with the MIS.
		tvr = MarketOrder.select('total(vol_remaining) as vol_remaining').where('market_item_summary_id = ? AND order_state = 0', market_item_summary_id)[0].vol_remaining

		#Update the MIS's ASP value.
		mis[0].average_sale_price = asp

		#Update the MIS's TVE value
		mis[0].total_vol_entered = tve
		
		#Update the MIS's TVR value
		mis[0].total_vol_remaining = tvr

		#Save the updated MIS.
		mis[0].save
	end
end