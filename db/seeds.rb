# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

category = Category.create!(name: "Cartoons")

Video.create!(title: "Southpark", description: "Description of the Southpark video", small_cover_url: "/tmp/south_park.jpg",large_cover_url: "/tmp/south_park.jpg", category: category)
Video.create!(title: "Futurama", description: "Description of the Futurama video", small_cover_url: "/tmp/futurama.jpg",large_cover_url: "/tmp/futurama.jpg", category: category)



