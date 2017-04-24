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


  # def new
  #   @product = Product.new
  #   @merchant = Merchant.find(params[:merchant_id])
  # end
  #
  # def create
  #   @merchant = Merchant.find(params[:merchant_id])
  #   @product = @merchant.products.create(product_params)
  #   if @product.id != nil
  #     flash[:success] = "Successfully created new product"
  #     redirect_to merchant_products_path(@merchant.id)
  #   else
  #     flash[:failure] = "Product wasn't created"
  #     render :new, status: :bad_request
  # end

  def new
    @merchant = Merchant.find_by(id: params[:merchant_id])
    if @merchant.nil?
      flash[:message] = "Could not find that merchant"
      redirect_to products_path, status: :not_found
      return
    end
    @product = @merchant.products.build
  end


  def create
    @merchant = Merchant.find_by(id: params[:merchant_id])
    if @merchant.nil?
      flash[:message] = "Could not find that merchant"
      redirect_to products_path, status: :not_found
      return
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
      flash[:message] = "Could not find that product"
      redirect_to products_path, status: :not_found
      return
    end
    @order_product = OrderProduct.new
  end


  def edit
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      flash[:message] = "Could not find that product"
      redirect_to products_path, status: :not_found
      return
    end
    @merchant = @product.merchant
  end


  def update
    @product  = Product.find_by(id: params[:id])
    if @product.nil?
      flash[:message] = "Could not find that product"
      redirect_to products_path, status: :not_found
      return
    else
      @merchant = @product.merchant
      @product.update_attributes(product_params)
      if @product.save
        redirect_to product_path(@product)
      else
        flash[:message] = "Bad News. Unable to update item."
        render :edit, status: :bad_request
      end
    end
  end

  def retire
    @product = Product.find(params[:id])
    if @product.nil?
      flash[:message] = "Could not find that product"
      redirect_to products_path, status: :not_found
      return
    end
    @product.retired = true
    @product.save
    redirect_to product_path(@product)
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.nil?
      flash[:message] = "Could not find that product"
      redirect_to products_path, status: :not_found
      return
    end
    if @product.destroy
      redirect_to products_path
    end
  end


  private
  def product_params
    params.require(:product).permit(:name, :price, :photo_url, :description, :stock, :merchant_id)
  end
end
