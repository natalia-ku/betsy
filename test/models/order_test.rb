require "test_helper"

describe Order do

  describe "validations" do
    it "does not create an order without a status" do
      order = Order.new
      order.valid?.must_equal false
      order.errors.messages.must_include :status
    end

    it "does not create an order with a status other than pending or paid" do
      order = Order.new(status: "open")
      order.valid?.must_equal false
      order.errors.messages.must_include :status
    end

    it "successfully creates an order with a status of pending or paid" do
      order1 = Order.new(status: "pending")
      order2 = Order.new(status: "paid")

      # This must go through, so we use save!
      order1.save!
      order2.save!
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









end
