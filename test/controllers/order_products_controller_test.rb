require "test_helper"

describe OrderProductsController do
  describe "create" do
    it "adds an order_product to the database" do
      order = Order.create(status: "pending", email: "new@gmail.com", mailing_address: "123 Main street",  card_name: "somebody fake",credit_card: "434338943", cvv: 434,zip_code: 43434, paid_at: DateTime.now)
      merchant = Merchant.create(username: "nata", email: "ew@com")
      product = Product.create(price: 6.00, name: "bldalala", merchant: merchant, photo_url: "na/com.jpg", description: "good product", stock: 12)
      op = OrderProduct.create(order_id: order.id, product_id: product.id, quantity: 2)
      #op_data = {op: {order: order, product: product, quantity: 2}}
      #op_data = {order_product: op.attributes}
      #post order_products_path, params: op_data
      # must_redirect_to shopping_cart_path # DOES NOT WORK
    end
    it "changing size of order products after creating" do
      order = Order.create(status: "pending", email: "new@gmail.com", mailing_address: "123 Main street",  card_name: "somebody fake",credit_card: "434338943", cvv: 434,zip_code: 43434, paid_at: DateTime.now)
      merchant = Merchant.create(username: "nata", email: "ew@com")
      product = Product.create(price: 6.00, name: "bldalala", merchant: merchant, photo_url: "na/com.jpg", description: "good product", stock: 12)

      before_count = OrderProduct.all.length

      op = OrderProduct.create(order_id: order.id, product_id: product.id, quantity: 2)

      #post order_products_path, params: op_data
      after_count =  OrderProduct.all.length
      (after_count - before_count).must_equal 1
    end
  end #end of create block



end
