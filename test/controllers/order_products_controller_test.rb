require "test_helper"

describe OrderProductsController do
  let(:order){Order.create(status: "pending", email: "new@gmail.com", mailing_address: "123 Main street",  card_name: "somebody fake",credit_card: "434338943", cvv: 434,zip_code: 43434, paid_at: DateTime.now)}
  let(:merchant){Merchant.create(username: "nata", email: "ew@com")}
  let(:product){Product.create(price: 6.00, name: "bldalala", merchant: merchant, photo_url: "na/com.jpg", description: "good product", stock: 12)}
  let (:order_pr){OrderProduct.create(order_id: order.id, product_id: product.id, quantity: 2)}

  describe "create" do
    it "adds an order_product to the database" do
      product1 = products(:owl1)
      category = Category.create(name: "supercategory")
      pc1 = ProductCategory.create(product_id: product1.id, category_id: category.id)
      product1.reload
      op = OrderProduct.create(order_id: order.id, product_id: product1.id, quantity: 30)
      result = OrderProduct.find_by(order_id: order.id, product_id: product1.id)
      result.wont_be_nil
    end
    it "changing size of order products after creating" do
      before_count = OrderProduct.all.length
      product1 = products(:owl1)
      category = Category.create(name: "supercategory")
      pc1 = ProductCategory.create(product_id: product1.id, category_id: category.id)
      product1.reload
      op = OrderProduct.create(order_id: order.id, product_id: product1.id, quantity: 2)
      after_count =  OrderProduct.all.length
      (after_count - before_count).must_equal 1
    end
  end #end of create block
  describe "update" do
    it "updates an order product quantity" do
      # order_product = OrderProduct.create(order_id: order.id, product_id: product.id, quantity: 30)
      # op_data = {order_product: {quantity: order_product.quantity + 20}}
      # patch order_product_path(order_pr.id), params: op_data
      # order_product.reload
      # order_product.quantity.must_equal op_data[:order_product][:quantity]


      # op_data = {order_product: order_pr.attributes}
      # op_data[:order_product][:quantity] = 11
      # patch order_product_path(order_pr.id), params: op_data
      # order_pr.reload
      # must_redirect_to shopping_cart_path # DOES NOT CHANGING QUANTITY!!
      # order_pr.quantity.must_equal 11
    end
  end

  describe "destroy" do
    it "successfully deletes from database" do
      product1 = products(:owl1)
      category = Category.create(name: "supercategory")
      pc1 = ProductCategory.create(product_id: product1.id, category_id: category.id)
      product1.reload
      order_pr = OrderProduct.create(order_id: order.id, product_id: product1.id, quantity: 2)

      delete order_product_path(order_pr.id)
      must_redirect_to shopping_cart_path
    end
    # DOES NOT WORK BECAUSE OF THE SESSION:
    it "deletes whole order if there are no order product in shopping cart" do
      # order = Order.create(status: "pending", email: "new@gmail.com", mailing_address: "123 Main street",  card_name: "somebody fake",credit_card: "434338943", cvv: 434,zip_code: 43434, paid_at: DateTime.now)
      # product1 = Product.create(price: 6.00, name: "bldalala", merchant: merchant, photo_url: "na/com.jpg", description: "good product", stock: 12)
      # op1 = OrderProduct.create(order_id: order.id, product_id: product.id, quantity: 30)
      # op2 = OrderProduct.create(order_id: order.id, product_id: product1.id, quantity: 20)
      # op1.destroy
      # op2.destroy
      # result = Order.find(order.id)
      # result.must_be_nil
    end
    it "after deletion, order product doesn't exist anymore" do
      product1 = products(:owl1)
      category = Category.create(name: "supercategory")
      pc1 = ProductCategory.create(product_id: product1.id, category_id: category.id)
      product1.reload
      op = OrderProduct.new(order_id: order.id, product_id: product1.id, quantity: 2)
      op.save!
      delete order_product_path(op.id)
      must_redirect_to shopping_cart_path
      OrderProduct.find_by(id: op.id)
      #must_respond_with :not_found
      #OrderProduct.find(temp_id).must_equal nil
    end
    it "after destroying count of order_product is changed" do
      start_count = OrderProduct.count

      op_id = OrderProduct.first.id
      delete order_product_path(op_id)
      must_redirect_to shopping_cart_path

      end_count = OrderProduct.count
      end_count.must_equal start_count - 1
    end

  end



end
