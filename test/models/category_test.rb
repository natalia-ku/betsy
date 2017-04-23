require "test_helper"

describe "Category" do
  let(:category) { Category.new(name: "food") }
  let(:category_no_attributes) { Category.new }

  describe "Validation" do
    it "can be created with all attributes" do
      result = category.valid?
      result.must_equal true
    end
    it "cannot be created without attrubute name" do
      result = category_no_attributes.valid?
      result.must_equal false
      category_no_attributes.errors.messages.must_include :name
    end
    it "cannot be created with invalid name" do
      names = ['ca12t', '21og', '422', "d---sdsd", nil]
      names.each do |name|
        c = Category.create(name: name)
        c.valid?.must_equal false
        c.errors.messages.must_include :name
      end
    end
  end

  describe "Relationship" do
    # it "category has products" do
    #   c = categories(:food)
    #   pr = Product.create(name: "table", price: 23, photo_url: "ew", description: "wqwq", stock: 32, merchant: merchants(:petr))
    #   product_category = ProductCategory.create(category: c, product: pr)
    #   c.products.must_include pr
    # end
    #
    #  it "product has categories" do
    #   c = Category.create(name: "food")
    #   pr = Product.create(name: "table", price: 23, photo_url: "ew", description: "wqwq", stock: 32, merchant: Merchant.create(username: "blablabla", email: "foo.gmail.com"))
    #   product_category = ProductCategory.create(category: c, product: pr)
    #   pr.categories.must_include c
    # end

    # it "product has categories" do
    #   c = Category.create(name: "food")
    #
    #   6.times do |i|
    #     pr = Product.create(name: "table", price: 23, photo_url: "ew", description: "wqwq", stock: 32, merchant: Merchant.new)
    #     ProductCategory.create!(category: c, product: pr)
    #   end
    #   c.products.length.must_equal 6
    #   Category.find(c.id).products.length.must_equal 6
    # end


  end

end
