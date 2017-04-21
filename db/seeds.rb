# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all
Product.destroy_all
Merchant.destroy_all


10.times do
  category = Category.new
  category.name = Faker::Pokemon.name
  category.save!
end

10.times do
  merchant = Merchant.new
  merchant.username = Faker::Name.first_name
  merchant.email = Faker::Internet.email
  merchant.save!
end

10.times do |i|
  product = Product.new
  product.name ="product_##{i}"
  product.price = Faker::Number.decimal(2)
  product.photo_url = "category_img/#{rand(12)}.jpg"
  product.description = Faker::Lorem.paragraph
  product.stock = rand(1..10)
  product.merchant_id = Merchant.all.sample.id

  product.save!
  # product_category = ProductCategory.create({:category_id => Category.all.sample.id, :product_id => product.id})
end
