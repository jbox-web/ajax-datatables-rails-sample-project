# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Post.all.count == 0
  puts "Creating 100 posts"
  100.times do |i|
    Post.create!(name: "Name #{i}", title: "Title #{i}", content: "Content #{i}", rooms: (1..200).to_a.sample, enabled: [true, false].sample)
  end
else
  puts "Skip posts creation"
end

if User.all.count == 0
  puts "Creating 100 users"
  100.times do |i|
    User.create!(name: "Name #{i}", title: "Title #{i}", content: "Content #{i}", rooms: (1..200).to_a.sample, enabled: [true, false].sample)
  end
else
  puts "Skip users creation"
end

all_cities = []
all_countries = []

File.readlines("#{ Rails.root }/db/IATA_airports.csv").each do |line|
  iata, type, name_ru, name, coordinates, timezone, parent_name = line.split(';').map(&:strip)
  latitude, longitude = coordinates.split(':') if coordinates

  case type
  when "city"
    all_cities << { iata: iata, name: name, parent_name: parent_name, timezone: timezone }
  when "country"
    all_countries << { iata: iata, name: name }
  end
end

all_cities = all_cities.group_by { |c| c[:parent_name] }


if Country.all.count == 0
  puts "Creating countries"
  Country.create all_countries
else
  puts "Skip countries creation"
end

if City.all.count == 0
  puts "Creating cities"

  all_cities.each do |country_name, cities|
    country = Country.find_by_name country_name
    cities.each do |city_attr|
      city_attr[:country_id] = country.id
      city_attr.delete :parent_name
      City.create city_attr
    end
  end
else
  puts "Skip cities creation"
end
