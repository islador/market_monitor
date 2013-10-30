module OutpostBuilder
	def self.add_outposts(api_id, cache_time_id)

		#Build the api model
		api_model = Api.where('id = ?', api_id)

		#Build the api for the eve gem
		api = Eve::API.new(:key_id => api_model[0].key_id, :v_code => api_model[0].v_code)

		#Specify the query to run and run it
		result = api.eve.conquerable_station_list

		#Iterate through the results
		result.outposts.each do |sta|
			#Check if there are existing stations that match the returned ID
		    if Station.where('station_id = ?', sta.stationID).empty?
		    	#if not, build a hash with the returned values
		    	station_hash = {"station_id" => sta.stationID, "name" => sta.stationName}
		    	#then build a station model with that hash
		    	new_station = Station.new(station_hash)
		    	#and save that model to the database
		    	new_station.save
		    	puts "Added station: " + new_station.station_id.to_s + " " + new_station.name
		    else
		    	#otherwise, trigger an update call
		    	update_outpost(sta.stationID, sta.stationName)
		    end
		end

		#Build a new CacheTimes record in the database to ensure this data is kept up to date.
		@new_timer = CacheTimes.new(user_id: api_model[0].user_id, api_id: api_id, call_type: 6, cached_time: result.cachedUntil)
		@new_timer.save

		puts "Completed OutpostBuilder.add_outposts at #{DateTime.now}"
	end

	def self.update_outpost(stationID, stationName)
		#pull a copy of the station record that triggered this call
		station_model = Station.where('station_id = ?', stationID)

		#compare that model's name to the value returned from the API
		if station_model[0].name.eql?(stationName) == false
			#if they do not match, overwrite the database record with the new value.
			station_model[0].name = stationName
			station_model[0].save
			puts "Updated station: " + stationID.to_s + " " + stationName
		end
	end
end