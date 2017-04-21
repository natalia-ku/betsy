require "test_helper"

describe ProductsController do
    describe "index" do
      it "succeeds with many products" do
        # Assumption: there are many users in the DB

        Product.count.must_be :>, 0
        get products_path
        must_respond_with :success
      end

      it "succeeds with no products" do
        # Start with a clean slate
        Product.destroy_all
        get products_path
        must_respond_with :success
      end
    end
end
