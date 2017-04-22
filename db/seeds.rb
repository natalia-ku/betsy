# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


csv_text = File.read('db/order_seeds.csv')
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  o = Order.new
  o.status = row['status']
  o.email = row['email']
  o.mailing_address = row['mailing_address']
  o.card_name = row['card_name']
  o.credit_card = row['credit_card']
  o.cvv = row['cvv']
  o.zip_code = row['zip_code']
  o.paid_at = DateTime.parse(row['paid_at'])
  o.save
end
