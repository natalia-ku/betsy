class ProdcutsController < ApplicationController

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

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      head :not_found
    end
    @order_product = OrderProduct.new(product: @product, order: current_order)
    # ??? do we need current order here???
    @current_order = current_order
  end



  private
  def product_params
    return params.require(:product).permit( :name, :photo_url, :price, :stock )
  end

end
