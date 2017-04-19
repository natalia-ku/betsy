require "test_helper"

describe Order do

  describe "validations" do
    it "requires a status" do
      order = Order.new
      order.valid?.must_equal false
      order.errors.messages.must_include :status
    end



  end

end
