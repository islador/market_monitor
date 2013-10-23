require 'sqlite3'


#Open the Database connection
#@odyssey = SQLite3::Database.open('./db/odyssey1-1.db')
@odyssey = SQLite3::Database.open('./db/odyssey11.sqlite')

#Select from the database

#########
#@stations = @odyssey.query("SELECT stationName, stationID FROM staStations").collect{|row| {:name => row[0], :station_id => row[1]}}

#@stations.each do |sta|
#	puts sta[:name]
#	puts sta[:station_id]
#end
#puts @stations.count
#########

@stations = @odyssey.query("SELECT stationName, stationID FROM staStations").collect{|row| {:name => row[0], :station_id => row[1]}}

#@stations.each do |sta|
#	puts sta[:name]
#	puts sta[:name].encoding
#	puts sta[:station_id]
#end

puts "Stations Count: " + @stations.count.to_s
FileUtils.mkdir_p "#{Rails.root}/db/seed/stations"
File.open("#{Rails.root}/db/seed/stations/stations2.yml",'w') do |out|
	YAML.dump(@stations, out)
end

puts "Stations loaded to file."

#scrub sourced from http://dotmh.com/post/28975203973/invalid-byte-sequence-in-utf-8
def scrub string 
  string.force_encoding("ISO-8859-1").encode("utf-8", replace: nil)
end

@items = @odyssey.query("SELECT typeName, typeID, volume, marketGroupID FROM invTypes WHERE published = 1").collect{|row| {:name => row[0], :type_id => row[1], :volume => row[2], :market_group_id => row[3]}}


meow = {"name" => nil, "type_id" => nil, "volume" => nil, "market_group_id" => nil}

FileUtils.mkdir_p "#{Rails.root}/db/seed/items"
File.open("#{Rails.root}/db/seed/items/items.yml", 'w') do |out|
	@items.each do |items|
		#puts "Name: " + scrub(items[:name])
		#puts "TypeID: " + items[:type_id].to_s
		#puts "Volume: " + items[:volume].to_s
		#puts "MarketGropuID: " + items[:market_group_id].to_s

		meow["name"] = scrub(items[:name])
		meow["type_id"] = items[:type_id]
		meow["volume"] = items[:volume]
		meow["market_group_id"] = items[:market_group_id]

		YAML.dump(meow, out)
	end
end

#yehuda katz encoding in rails


puts "Items Count: " + @items.count.to_s

#FileUtils.mkdir_p "#{Rails.root}/db/seed/items"
#File.open("#{Rails.root}/db/seed/items/items.yml",'w') do |out|
#	YAML.dump(@items, out)
#end

#FileUtils.mkdir_p "#{Rails.root}/db/seed/stations"
#File.open("#{Rails.root}/db/seed/stations/stations2.yml",'w') do |out|
#	YAML.dump(@items, out)
#end

puts "Items loaded to file."



#File.open("./db/region.yml",'w') do |out|
#	YAML.dump(@regions, out)
#end
#meow.each do |m|
#	name.each do |n|
#		puts m
#		puts n
#	end
#end

#name.each do |n|
#	puts n
#end