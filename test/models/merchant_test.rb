require "test_helper"

describe Merchant do
  describe 'validations' do
    it "Can be created with name" do
      a = Merchant.create!(username: "Dan")
      result = a.valid?
      result.must_equal true
    end

    it "Can be created with email" do


    end

    it "email has '@' sign" do


    end
  end
end
