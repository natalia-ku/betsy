require "test_helper"

describe Merchant do
  describe 'validations' do
    it "requires a username" do
      a = Merchant.create!(username: "Dan", email: "222@adaworld.com")
      result = a.valid?
      result.must_equal true
    end

    it "requires a unique username" do
      username = "test username"
      merchant1 = Merchant.new(username: "username", email: "444@adaworld.com")
      merchant1.save!

      merchant2 = Merchant.new(username: "username", email: "555@adaworld.com")
      result = merchant2.save
      result.must_equal false
      merchant2.errors.messages.must_include :username
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

  describe "relations" do
    it "has a list of products" do
      dan = merchants(:dan)
      dan.must_respond_to :products
      dan.products.each do |product|
      product.must_be_kind_of Product
      end
    end
  end

  describe "model methods" do
    
  end
end
