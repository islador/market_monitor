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

		#Assemble a hash to standardize queries.
		input_hash = {stationID: nil, charID: nil, ownerID: nil, bid: nil}
		
		#Populate the hash based on recieved data.
		input_hash[:stationID] = @input["station_id"].eql?("All") ? nil : @input["station_id"]
		input_hash[:charID] = @input["listing_character_id"].eql?("All") ? nil : @input["listing_character_id"]
		input_hash[:ownerID] = @input["owner_id"].eql?("All") ? nil : @input["owner_id"]
		input_hash[:bid] = @input["type"].eql?("false") ? false : true

		#Build the query string
		#query_string
		query_string = ""
		#a counter for and status
		and_counter = 0
		input_hash.each do |key, value|
			#Check for a nil value, if found, do not append to string for this pass
		    if value != nil
		    	#check for stationID
		        if key.to_s.eql?("stationID")
		        	#check for an and_value
		        	if and_counter == 1
		        		#add an AND to the query string
		        		query_string = query_string + " AND "
		        	end
		        	#add a query for station ID to the query_string
		        	query_string = query_string + "station_id = :stationID"
		        	#set the and_counter to 1 as an AND will be needed if another item is appended
		        	and_counter = 1
		        end
		        #check for charID
		        if key.to_s.eql?("charID")
		        	#check for an and_value
		        	if and_counter == 1
		        		#add an AND to the query string
		        		query_string = query_string + " AND "
		        	end
		        	#append a query for char_id to the query_string
		        	query_string = query_string + "char_id = :charID"
		        	#set the and_counter to 1 as an AND will be needed if another item is appended
		        	and_counter = 1
		        end
		        #check for ownerID
		        if key.to_s.eql?("ownerID")
		        	if and_counter == 1
		        		query_string = query_string + " AND "
		        	end
		        	query_string = query_string + "char_id = :ownerID AND entity = 1"
		        	and_counter = 1
		        end
		        #check for bid
		        if key.to_s.eql?("bid")
		        	if and_counter == 1
		        		query_string = query_string + " AND "
		        	end
		        	query_string = query_string + "bid = :bid"
		        	and_counter = 1
		        end
		    end
		end

		#Assemble query
		@mis = current_user.market_item_summaries.where(query_string, input_hash)


		format.js   { render :partial => '/market_item_summaries/corporation_table', :content_type => 'text/html' }


		format.js   { render :partial => '/market_item_summaries/character_table', :content_type => 'text/html' }
	end

	def section_owner(owner_id)


	end
end
