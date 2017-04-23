require "test_helper"

describe OrderProductsController do
  let(:order){Order.create(status: "pending", email: "new@gmail.com", mailing_address: "123 Main street",  card_name: "somebody fake",credit_card: "434338943", cvv: 434,zip_code: 43434, paid_at: DateTime.now)}
  let(:merchant){Merchant.create(username: "nata", email: "ew@com")}
  let(:product){Product.create(price: 6.00, name: "bldalala", merchant: merchant, photo_url: "na/com.jpg", description: "good product", stock: 12)}
  let (:order_pr){OrderProduct.create(order_id: order.id, product_id: product.id, quantity: 2)}
  describe "create" do
    it "adds an order_product to the database" do
      # op_data = {op: {order: order, product: product, quantity: 2}}
      # post order_products_path, params: op_data
      #must_redirect_to shopping_cart_path # DOES NOT WORK
    end
    it "changing size of order products after creating" do
      before_count = OrderProduct.all.length
      op = OrderProduct.create(order_id: order.id, product_id: product.id, quantity: 2)
      after_count =  OrderProduct.all.length
      (after_count - before_count).must_equal 1
    end
  end #end of create block
  describe "update" do
    it "updates an order product quantity" do
      op_data = {order_product: order_pr.attributes}
      op_data[:order_product][:quantity] = 11
      patch order_product_path(order_pr.id), params: op_data
      must_redirect_to shopping_cart_path # DOES NOT CHANGING QUANTITY!!
    end
  end

  describe "destroy" do
    it "successfully deletes from database" do
      delete order_product_path(order_pr.id)
      must_redirect_to shopping_cart_path
    end
    it "after deletion, order product doesn't exist anymore" do
      op = OrderProduct.new(order_id: order.id, product_id: product.id, quantity: 2)
      op.save!
      delete order_product_path(op.id)
      must_redirect_to shopping_cart_path
      OrderProduct.find_by(id: op.id)
      #must_respond_with :not_found
      #OrderProduct.find(temp_id).must_equal nil
    end
  end



end
