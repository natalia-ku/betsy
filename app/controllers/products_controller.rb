class ProductsController < ApplicationController

  def index
    if params[:merchant_id]
      # localhost:3000/merchants/2/products
      # we are in the nested route
      # retrieve products based on the merchant

      @products = Merchant.find(params[:merchant_id]).products
    else
      #localhost:3000/products
      # we are in our 'regular' route
      @products = Product.all
    end
  end

def show
  @product = Product.find_by(id: params[:id])
  if @product.nil?
    head :not_found
  end
end




  def new
    @product = Product.new
    @merchant = Merchant.find(params[:merchant_id])
  end





end
