# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



User.create(
  username: "super_user",
  password: "password",
  email: "super_user@gmail.com"
)
# db/seeds.rb

# Create some sample artists with random names and bios using Faker
10.times do
  Artist.create(
    name: Faker::Name.name,
    bio: Faker::Lorem.paragraph
  )
end


10.times do
  Song.create(
    artist_id: rand(1..10),
    title: Faker::Artist.name,
  )
end
