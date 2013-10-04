module ApiActiveChecker
	# do some logic here to see if the API is live.
	# http://wiki.eve-id.net/APIv2_Eve_ErrorList_XML looks like
	# a good place to start to define that logic.
	def self.checkactive(api_id, cache_time_id)
		@user_id = api_id.user_id
		@api = Api.find_by_id(api_id)
		@active = @api.active

		puts "Unfinished ApiActiveChecker.checkactive fired at #{DateTime.now}"

		if @active == 1

			api = Eve::API.new(:key_id => @api.key_id, :v_code => @api.v_code)
	    	result = api.account.apikeyinfo

			@newTimer = CacheTimes.new(user_id: @user.id, api_id: api_id, call_type: 1, cached_time: result.cachedUntil)
			puts @newTimer
			@newTimer.save
			
		end

		CacheTimes.delete(cache_time_id)
	end
end