require "test_helper"

describe OrderProductsController do
  describe "create" do
      it "responds successfully " do
        get new_order_product_path
        must_respond_with :success
      end
  end #end of create block



end
