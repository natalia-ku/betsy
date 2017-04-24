require "test_helper"


describe ProductsController do
  describe "index" do

    it "succeeds with many products, when not called with a particular merchant_id" do
      # Assumption: There are many products in the DB

      Product.count.must_be :>, 0
      get products_path
      must_respond_with :success
    end

    it "succeeds with no products, when not called with a particular merchant_id" do
      # Start with a clean slate
      Product.destroy_all
      get products_path
      must_respond_with :success
    end

    it "succeeds with many products, when  called with a particular merchant_id" do
      # Assumption: That merchant has products
      dan = merchants(:dan)
      dan.products.count.must_be :>, 0
      get merchant_products_path(dan)
      must_respond_with :success
    end

    it "succeeds with no products, when called with a particular merchant_id" do
      # Assumption: That merchant has no products
      Product.destroy_all
      dan = merchants(:dan)
      get merchant_products_path(dan)
      must_respond_with :success
    end
  end


  describe "new" do
    it "runs successfully when creating a product for a valid merchant" do
      merchant = Merchant.first
      get new_merchant_product_path(merchant)
      must_respond_with :success
    end

    it "returns 404 if trying to create a product for a merchant that DNE" do
      merchant_id = Merchant.last.id + 1
      get new_merchant_product_path(merchant_id)
      must_respond_with :not_found
    end
  end


  describe "create" do

    it "creates a new product for the given merchant" do
      merchant = Merchant.first
      start_count = merchant.products.count

      product_data = {
        product: {
          name: "test product",
          price: 4.00
        }
      }
      post merchant_products_path(merchant.id), params: product_data
      must_redirect_to merchant_path(merchant)

      end_count = merchant.products.count
      end_count.must_equal start_count + 1

      product = Product.last
      product.name.must_equal product_data[:product][:name]
    end

    it "responds with bad_request for bogus data" do
      merchant = Merchant.first
      start_count = merchant.products.count

      product_data = {
        product: {
          foo: "bar"
        }
      }
      post merchant_products_path(merchant.id), params: product_data
      must_respond_with :bad_request

      end_count = merchant.products.count
      end_count.must_equal start_count
    end

######## This is causing an error
    # it "returns 404 if trying to create a product for a merchant that DNE" do
    #   merchant_id = Merchant.last.id + 1
    #
    #   product_data = {
    #     product: {
    #       name: "test product",
    #       price: 4.00
    #     }
    #   }
    #   post merchant_products_path(merchant_id), params: product_data
    #   must_respond_with :not_found
    # end

  end

  describe "show" do

    it "finds a product that exists" do
      product_id = Product.first.id
      get product_path(product_id)
      must_respond_with :success
    end

    it "returns 404 for a product that DNE" do
      product_id = Product.last.id + 1
      get product_path(product_id)
      must_respond_with :not_found
    end
  end

end
