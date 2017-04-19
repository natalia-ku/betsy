require "test_helper"

describe Review do
  describe 'validations' do
    it "Can be created with rating and review_text" do
      review = reviews(:one)
    end

    it "ranges between 1-5"
    
  end
end
