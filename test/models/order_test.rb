require "test_helper"

describe Order do

  describe "validations" do
    it "does not create an order without a status" do
      order = Order.new
      order.valid?.must_equal false
      order.errors.messages.must_include :status
    end

    it "does not create an order with a status other than pending, paid, complete, or cancelled" do
      order = Order.new(status: "open")
      order.valid?.must_equal false
      order.errors.messages.must_include :status
    end

    it "successfully creates an order with a valid status " do
      order1 = Order.new(status: "pending")
      order2 = Order.new(status: "paid")
      order3 = Order.new(status: "complete")
      order4 = Order.new(status: "cancelled")

      order2.attributes ={email: "me@aol.com", mailing_address: "12 34th St", card_name: "Olga Owl", credit_card: "1234", cvv: "567", card_expiration: DateTime.now, zip_code: "12345"}

      # This must go through, so we use save!
      order1.save!
      order2.save!
      order3.save!
      order4.save!
    end


    it "successfully creates an order with a paid status and the subsequently required fields " do

      order = Order.new(status: "paid")
      order.attributes ={email: "me@aol.com", mailing_address: "12 34th St", card_name: "Olga Owl", credit_card: "1234", card_expiration: DateTime.now, cvv: "567", zip_code: "12345"}

      # This must go through, so we use save!
      order.save!
    end


    it "requires an email if status is paid" do
      order = Order.new(status: "paid")
      order.attributes ={mailing_address: "12 34th St", card_name: "Olga Owl", credit_card: "1234", card_expiration: DateTime.now, cvv: "567", zip_code: "12345"}

      order.valid?.must_equal false
      order.errors.messages.must_include :email
    end


    it "requires a mailing address if status is paid" do
      order = Order.new(status: "paid")
      order.attributes ={email: "me@aol.com", card_name: "Olga Owl", credit_card: "1234", card_expiration: DateTime.now, cvv: "567", zip_code: "12345"}

      order.valid?.must_equal false
      order.errors.messages.must_include :mailing_address
    end

    it "requires a credit card name if status is paid" do
      order = Order.new(status: "paid")
      order.attributes ={email: "me@aol.com", mailing_address: "12 34th St", credit_card: "1234", card_expiration: DateTime.now, cvv: "567", zip_code: "12345"}

      order.valid?.must_equal false
      order.errors.messages.must_include :card_name
    end

    it "requires a credit card if status is paid" do
      order = Order.new(status: "paid")
      order.attributes ={email: "me@aol.com", mailing_address: "12 34th St", card_name: "Olga Owl", card_expiration: DateTime.now, cvv: "567", zip_code: "12345"}

      order.valid?.must_equal false
      order.errors.messages.must_include :credit_card
    end

    it "requires a cvv if status is paid" do
      order = Order.new(status: "paid")
      order.attributes ={email: "me@aol.com", mailing_address: "12 34th St", card_name: "Olga Owl", credit_card: "1234", card_expiration: DateTime.now, zip_code: "12345"}

      order.valid?.must_equal false
      order.errors.messages.must_include :cvv
    end

    it "requires a zip code if status is paid" do
      order = Order.new(status: "paid")
      order.attributes ={email: "me@aol.com", mailing_address: "12 34th St", card_name: "Olga Owl", credit_card: "1234", card_expiration: DateTime.now, cvv: "567"}

      order.valid?.must_equal false
      order.errors.messages.must_include :zip_code
    end
  end

  describe "total_price" do
    it "calculates total price of order "do
    product1 = Product.create(price: 6.00, name: "lkjdekjkalala",merchant: Merchant.create(username: "natkajia", email: "een@com"),description: "blablabla", stock: 3, photo_url: "na/com.jpg")
    product2 = Product.create(price: 16.00, name: "way",merchant: Merchant.create(username: "natkajia", email: "een@com"),description: "blablabla", stock: 3, photo_url: "na/com.jpg")

    order = Order.create(status: "paid", email: "new@gmail.com", mailing_address: "123 Main street",  card_name: "somebody fake",credit_card: "434338943", card_expiration: DateTime.now, cvv: 434,zip_code: 43434, paid_at: DateTime.now)
    op1 = OrderProduct.create(order: order, product: product1, quantity: 10)
    op2 = OrderProduct.create(order: order, product: product2, quantity: 10)
    order.total_price.must_equal 60 + 160
    end

  end

  describe "relations" do
    it "has a list of order_products" do
      sophia_cart= orders(:sophia_cart)
      sophia_cart.must_respond_to :order_products
      sophia_cart.order_products.each do |order_product|
        order_product.must_be_kind_of OrderProduct
      end
    end

    it "has a list of products" do
      sophia_cart= orders(:sophia_cart)
      sophia_cart.must_respond_to :products
      sophia_cart.products.each do |product|
        product.must_be_kind_of Product
      end
    end
  end
  describe "model methods" do
    it "can return the last four of a credit card number" do
      cart = orders(:sophia_cart)
      cart.last_four.must_equal "2232"
    end
  end
end
