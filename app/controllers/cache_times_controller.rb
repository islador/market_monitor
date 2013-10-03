class CacheTimesController < ApplicationController

	def checktimes

		#Assemble an array of cachetimes to iterate through
		@cached = []
		@cached = CacheTimes.pluck(:id)

		#Iterate through each cached time in the table.
		@cached.each do |n|

			#Evaluate if the cache timer has expired or not.
			if CacheTimes.find_by_id(n).cached_time < DateTime.now
				CacheTimes.find_by_id(n).call_type

	end
end