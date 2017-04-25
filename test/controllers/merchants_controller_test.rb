require "test_helper"

describe MerchantsController do
  describe "index" do
    it "succeeds with many merchants" do
      Merchant.count.must_be :>, 0

      get merchants_path
      must_respond_with :success
    end
  it "succeeds with no merchants" do
    Merchant.destroy_all

    get merchants_path
    must_respond_with :success
  end
end

  describe "show" do
    # needs a test for a logged-in merchant but I find disagreeing methods for testing session in rails 5
    it "won't let you access a Merchant that doesn't exist" do
      bogus_user_id = Merchant.last.id + 1
      get merchant_path(bogus_user_id)
      must_respond_with :redirect
    end
  end

end
