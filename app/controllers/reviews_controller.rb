class ReviewsController < ApplicationController

  def new
    @product = Product.find_by(id: params[:id])
    @review = Review.new

  end

  def create
    #@product = Product.find_by(id: params[:id])
    @review = Review.new(review_params)#(rating: params[:rating], review_text: params[:review_text], product_id: @product.id)
    if @review.save
      redirect_to product_path(@review.product_id)
    end
  end
end

private
def review_params
  params.require(:review).permit(:rating, :review_text, :product_id)
end

#@order_product = OrderProduct.new(quantity: params[:quantity], order_id: @current_order.id, product_id: params[:product_id])
