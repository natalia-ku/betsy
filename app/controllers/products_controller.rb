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


  def new
    @merchant = Merchant.find_by(id: params[:merchant_id])
    if @merchant.nil?
      return head :not_found
      ###what page to display???
    end
    @product = @merchant.products.build
  end


  def create
    @merchant = Merchant.find_by(id: params[:merchant_id])
    if @merchant.nil?
      return head :not_found
      ###what page to display???
    end
    @product = @merchant.products.build(product_params)
    if @product.save
      flash[:message] = "Woot! Successfully created the new item: #{@product.name}"
      redirect_to merchant_path(@merchant)
    else
      flash[:message] = "BooHoo. Unable to create new item."
      render :new, status: :bad_request
      #redirect_to merchant_path(@merchant)
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      head :not_found
      ###what page to display???
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      head :not_found
      ###what page to display???
    end
    @merchant = @product.merchant
  end



  private
  def product_params
    params.require(:product).permit(:name, :price, :photo_url, :description, :stock, :merchant_id)
  end

end
