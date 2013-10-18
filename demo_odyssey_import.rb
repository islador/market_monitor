require 'sqlite3'

#Open the Database connection
@odyssey = SQLite3::Database.open('./db/odyssey1-1.db')

#Select from the database

#meow = {"stationID" => nil, "stationName" => nil}

#meow = @odyssey.query("SELECT blueprintTypeID FROM invBlueprintTypes LIMIT 1")
#meow = @odyssey.query("SELECT stationName FROM staStations LIMIT 1")

#name = @odyssey.query("SELECT typeName FROM invTypes WHERE typeID = 681 LIMIT 1")

#@regions = @odyssey.query('SELECT regionName, regionID FROM mapRegions where regionName != "Unknown";').collect{|row| {:name => row[0], :region_id => row[1]}}

#@regions.each do |re|
#	#puts re[:name] + " " + re[:region_id]
#	puts re[:name]
#	puts re[:region_id]
#end

#########
#@stations = @odyssey.query("SELECT stationName, stationID FROM staStations").collect{|row| {:name => row[0], :station_id => row[1]}}

#@stations.each do |sta|
#	puts sta[:name]
#	puts sta[:station_id]
#end
#puts @stations.count
#########

@stations = @odyssey.query("SELECT stationName, stationID FROM staStations").collect{|row| {:name => row[0], :station_id => row[1]}}

@stations.each do |sta|
	puts sta[:name]
	puts sta[:station_id]
end
puts @stations.count

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