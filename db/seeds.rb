# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cartoons = Category.create!(name: "Cartoons")

Video.create!(title: "Southpark", description: "Description of the Southpark video", small_cover_url: "/tmp/south_park.jpg",large_cover_url: "/tmp/south_park.jpg", category: cartoons)
Video.create!(title: "Futurama", description: "Description of the Futurama video", small_cover_url: "/tmp/futurama.jpg",large_cover_url: "/tmp/futurama.jpg", category: cartoons)
Video.create!(title: "The Lion King", description: "Description of the Lion Kingo video", small_cover_url: "/tmp/lion_king.jpg", large_cover_url: "/tmp/lion_king.jpg", category: cartoons)
Video.create!(title: "Toy Story", description: "Description of the Toy Story movie", small_cover_url: "/tmp/toy_story.jpg", large_cover_url: "/tmp/toy_story.jpg", category: cartoons)
Video.create!(title: "Family Guy", description: "Description of the Family Guy movie", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/family_guy.jpg", category: cartoons)
Video.create!(title: "Finding Nemo", description: "Description of the Finding Nemo movie", small_cover_url: "/tmp/finding_nemo.jpg", large_cover_url: "/tmp/finding_nemo.jpg", category: cartoons)
Video.create!(title: "Frozen", description: "Description of the Frozen movie", small_cover_url: "/tmp/frozen.jpg", large_cover_url: "/tmp/frozen.jpg", category: cartoons)


drama = Category.create!(name: "Drama")
Video.create!(title: "Monk", description: "Description of the Monk", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg", category: drama)