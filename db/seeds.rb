# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed methodology and implementation adapted from https://github.com/darkbushido/eve_db

# Seed the Item table with items.yml

items = YAML.load_file("#{Rails.root}/db/seed/items/items.yml")


# Seed the Station table with stations.yml. stations.yml does not contain outposts, those must be pulled from the API and appended.

stations = YAML.load_file("#{Rails.root}/db/seed/stations/stations.yml")