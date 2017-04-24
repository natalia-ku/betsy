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

    it "succeeds with no products, whencalled with a particular merchant_id" do
    # Assumption: That merchant has no products
      Product.destroy_all
      dan = merchants(:dan)
      get merchant_products_path(dan)
      must_respond_with :success
    end
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

  # describe "new" do
  #   it "runs successfully" do
  #     get new_product_path
  #     must_respond_with :success
  #   end
  # end
end
