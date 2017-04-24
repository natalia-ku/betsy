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
    it "succeeds for an extant merchant" do
      get merchant_path(Merchant.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus merchant" do
      bogus_user_id = Merchant.last.id + 1
      get merchant_path(bogus_user_id)
      must_respond_with :not_found
    end
  end
end
