class ReviewsController < ApplicationController

  def new

  end

  def create
    @product = Product.find_by(id: params[:id])
    @review = Review.new

  end

end
