class ProductsController < ApplicationController
  def index
  @products = Product.all
end
def new
  @product = Product.new
  @merchant = Merchant.find(params[:merchant_id])
end

def create
  @merchant = Merchant.find(params[:merchant_id])
  @product = @merchant.products.create(product_params)
end
end
