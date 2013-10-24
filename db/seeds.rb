# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed methodology and implementation adapted from https://github.com/darkbushido/eve_db

# Seed the Item table with items.yml

items = YAML.load_documents(File.read("#{Rails.root}/db/seed/items/items.yml"))
puts "Begining to load items."
items.each do |it|
	yaml_item = Item.new("name" => it["name"], "type_id" => it["type_id"], "volume" => it["volume"], "market_group_id" => it["market_group_id"])
	yaml_item.save
	puts "Items are %" + (items.index(it) / 136).to_s + " finished."
end
puts "Items Loading Complete"



# Seed the Station table with stations.yml. stations.yml does not contain outposts, those must be pulled from the API and appended.

stations = YAML.load_file("#{Rails.root}/db/seed/stations/stations.yml")
puts "Begining to load stations"
stations.each do |sta|
	# sta contains a hash of symbols, not a hash of strings/ints
	yaml_station = Station.new("name" => sta[:name], "station_id" => sta[:station_id])
	yaml_station.save
	puts "Stations are %" + (stations.index(sta) / 51).to_s + " finished."
end
puts "Stations Loaded successfully"