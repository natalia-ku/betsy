class ProductsController < ApplicationController

  def index
    if params[:merchant_id]
      @merchant = Merchant.find_by(id: params[:merchant_id])
      @products = @merchant.products
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @product = @merchant.products.create(product_params)
    if @product.id != nil
      flash[:success] = "Successfully created new product"
      redirect_to merchant_products_path(@merchant.id)
    else
      flash[:failure] = "Product wasn't created"
      render :new, status: :bad_request
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      head :not_found
    end
    @order_product = OrderProduct.new  
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy

      redirect_to products_path
    end
  end
  private
  def product_params
    return params.require(:product).permit( :name, :photo_url, :price, :stock )
  end
end
