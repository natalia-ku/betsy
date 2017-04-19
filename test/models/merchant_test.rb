require "test_helper"

describe Merchant do
  describe 'validations' do
    it "Can be created with name" do
      a = Merchant.create!(username: "Dan", email: "222@adaworld.com")
      result = a.valid?
      result.must_equal true
    end

    it "Can be created with email" do
      a = Merchant.create!(username: "Jamie", email: "111@adaworld.com")
      result = a.valid?
      result.must_equal true
    end

    it "email has '@' sign" do
      a = Merchant.create!(username: "Sofi", email: "333@adaworld.com")
      a.email.include? "@"
    end
  end
end
