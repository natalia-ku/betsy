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
    @merchant = Merchant.find(params[:merchant_id])
    @product = @merchant.products.build
  end


  def create
    @merchant = Merchant.find(params[:merchant_id])
    @product = @merchant.products.build(product_params)
    if @product.save
      flash[:message] = "Woot"
      redirect_to merchant_path(@merchant)
    else
      flash[:message] = "BooHoo"
      redirect_to merchant_path(@merchant)
    end
    # if @work.save
    #   flash[:status] = :success
    #   flash[:result_text] = "Successfully created #{@media_category.singularize} #{@work.id}"
    #   redirect_to works_path(@media_category)
    # else
    #   flash[:status] = :failure
    #   flash[:result_text] = "Could not create #{@media_category.singularize}"
    #   flash[:messages] = @work.errors.messages
    #   render :new, status: :bad_request
    # end
  end

end


private
def product_params
  params.require(:product).permit(:name, :price, :photo_url, :description, :stock, :merchant_id)
end
