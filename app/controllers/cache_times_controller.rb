# call_type translations
# | Code | Translation |
# |:----:|:-----------:|
# | 1 | Api Status |
# | 2 | Corp Market Order |
# | 3 | Corp Wallet Transactions |
# | 4 | Character Market Order |
# | 5 | Character Wallet Transactions |

class CacheTimesController < ApplicationController
	include ApiActiveChecker
	include CorpMarketOrders

	def checktimes

		#Assemble an array of cachetimes to iterate through
		@cached = []
		@cached = CacheTimes.pluck(:id)

		#Iterate through each cached time in the table.
		@cached.each do |n|

			#Evaluate if the cache timer has expired or not.
			if CacheTimes.find_by_id(n).cached_time < DateTime.now

				# If call_type is 1, fire off ApiActiveChecker's checkactive method.
				if CacheTimes.find_by_id(n).call_type == 1
					ApiActiveChecker.checkactive(CacheTimes.find_by_id(n).api_id)
				end

				# If call_type is 2, fire off CorpMarketOrders 
				if CacheTimes.find_by_id(n).call_type == 2
					CorpMarketOrders.input_orders(CacheTimes.find_by_id(n).api_id)
				end

				# If call_type is 3, fire CorpWalletTransactions
				if CacheTimes.find_by_id(n).call_type == 3
					CorpWalletTransactions.retrieve_corp_transactions(CacheTimes.find_by_id(n).api_id)
				end

				# If call_type is 4, fire CharacterMarketOrders
				if CacheTimers.find_by_id(n).call_type == 4
					CharMarketOrders.input_orders(CacheTimes.find_by_id(n).api_id)
				end
					

	end
end