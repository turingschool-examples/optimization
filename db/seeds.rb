# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ItemOrder.destroy_all
Review.destroy_all
Item.destroy_all
Order.destroy_all
User.destroy_all
Merchant.destroy_all
puts "Cleared DB"

100.times do
  Merchant.create!(name: Faker::Company.name, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip)
end
puts "Created Merchants"

100.times do
  User.create!(name: Faker::Name.name, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip, email: Faker::Internet.email, password: 'password')
end
puts "Created Users"

1_000.times do
  Order.create!(user: User.random, status: Faker::Number.within(range: 0..3))
end
puts "Created Orders"

10_000.times do
  Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price(range: 1..1000.0), inventory: Faker::Number.within(range: 1..1000), merchant: Merchant.random)
end
puts "Created Items"

100_000.times do
  Review.create!(title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, rating: Faker::Number.within(range: 1..5), item: Item.random)
end
puts "Created Reviews"

100_000.times do
  ItemOrder.create!(order: Order.random, item: Item.random, price: Faker::Commerce.price, quantity: Faker::Number.within(range: 1..100))
end
puts "Created ItemOrders"

admin = User.create(
  name: "Dorian Bouchard",
  address: "7890 Montreal Blvd",
  city: "New Orleans",
  state: "LA",
  zip: 70032,
  email: "admin@email.com",
  password: "password",
  role: 3
)
