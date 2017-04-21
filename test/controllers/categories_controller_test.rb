require "test_helper"

describe CategoriesController do
  describe "index" do
    it "succeeds with many categories" do
      # Assumption: there are many users in the DB
      Category.count.must_be :>, 0

      get categories_path
      must_respond_with :success
    end

    it "succeeds with no categories" do
      # Start with a clean slate
      Category.destroy_all

      get categories_path
      must_respond_with :success
    end
  end

  INVALID_CATEGORIES = ["nope", "42", "", "  ", "albumstrailingtext"]
  describe "show" do
    it "succeeds for an extant category" do
      get category_path(Category.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus category" do
      # User.last gives the user with the highest ID
        bogus_category_id = Category.last.id + 10
        get category_path(bogus_category_id)
        must_respond_with :not_found    
    end
  end
end
