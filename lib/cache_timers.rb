# call_type translations
# | Code | Translation |
# |:----:|:-----------:|
# | 1 | Api Status |
# | 2 | Corp Market Order |
# | 3 | Corp Wallet Transactions |
# | 4 | Character Market Order |
# | 5 | Character Wallet Transactions |

module CacheTimers
	include ApiActiveChecker
	include CorpMarketOrders
	include CorpWalletTransactions
	include CharMarketOrders
	include CharWalletTransactions

	def self.checktimes

		#Assemble an array of cachetimes to iterate through
		puts "Fired CacheTimers.checktimes at #{DateTime.now}"
		@cached = []
		@cached = CacheTimes.pluck(:id)

		#Iterate through each cached time in the table.
		@cached.each do |n| #this is an N+1 sql query, it should be fixed.
			

			#Evaluate if the cache timer has expired or not.
			if CacheTimes.find_by_id(n).cached_time < DateTime.now
				puts "The timer for Api_id #{CacheTimes.find_by_id(n).api_id} has expired."

				# If call_type is 1, fire off ApiActiveChecker's checkactive method.
				if CacheTimes.find_by_id(n).call_type == 1
					puts "Fired call_type 1 - ApiActiveChecker.checkactive."
					ApiActiveChecker.checkactive(CacheTimes.find_by_id(n).api_id, n)
				end

				# If call_type is 2, fire off CorpMarketOrders 
				if CacheTimes.find_by_id(n).call_type == 2
					puts "Fired call_type 2 - CorpMarketOrders.input_orders."
					CorpMarketOrders.input_orders(CacheTimes.find_by_id(n).api_id, n)
				end

				# If call_type is 3, fire CorpWalletTransactions
				if CacheTimes.find_by_id(n).call_type == 3
					puts "Fired call_type 3 - CorpWalletTransactions.retrieve_corp_transactions."
					CorpWalletTransactions.retrieve_corp_transactions(CacheTimes.find_by_id(n).api_id, n)
				end

				# If call_type is 4, fire CharacterMarketOrders
				if CacheTimers.find_by_id(n).call_type == 4
					puts "Fired call_type 4 - CharMarketOrders.input_char_orders."
					CharMarketOrders.input_char_orders(CacheTimes.find_by_id(n).api_id, n)
				end

				# If call_type is 5, fire CharacterWalletTransactions
				if CacheTimes.find_by_id(n).call_type == 5
					puts "Fired call_type 5 - CharWalletTransactions.retrieve_char_transactions."
					CharWalletTransactions.retrieve_char_transactions(CacheTimes.find_by_id(n).api_id, n)
				end
			end
		end
		puts "Finished CheckTimers.checktimes at #{DateTime.now}"
	end
end