module ApiActiveChecker
	# do some logic here to see if the API is live.
	# http://wiki.eve-id.net/APIv2_Eve_ErrorList_XML looks like
	# a good place to start to define that logic.
	def self.checkactive(api_id, cache_time_id)
		@user = User.find_by_id(Api.find_by_id(api_id).user_id)
		@active = Api.find_by_id(api_id).active

		puts "Unfinished ApiActiveChecker.checkactive fired at #{DateTime.now}"

		if @active == 1

			api = Eve::API.new(:key_id => Api.find_by_id(api_id).key_id, :v_code => Api.find_by_id(api_id).v_code)
	    	result = api.account.apikeyinfo

	    	if result.accessMask != nil
				@newTimer = CacheTimes.new(user_id: @user.id, api_id: api_id, call_type: 1, cached_time: result.cachedUntil)
				@newTimer.save
			else 
				Api.find_by_id(api_id).active = 0
			end
		end

		#CacheTimes.delete(cache_time_id)
	end
end