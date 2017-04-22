class OrderProductsController < ApplicationController
  def new
    @order_product = OrderProduct.new
  end

  def create
    @order_product = OrderProduct.new(quantity: params[:quantity], order_id: params[:order_id], product_id: params[:product_id])
    @order_product.quantity = params[:quantity].to_i
    if @order_product.save!
      redirect_to shopping_cart_path
    else
      redirect_to product_path(@order_product.product_id)
    end
  end

  def index
    @order_products = OrderProduct.all
  end

  def update #update quantity
    @order = current_order
    @order_product = OrderProduct.find(params[:id])
    @order_product.quantity = params[:quantity].to_i
    @order_product.save
    redirect_to shopping_cart_path
  end

  def destroy
    @order = current_order
    @order_product = OrderProduct.find(params[:id])
    if @order_product.destroy
      redirect_to shopping_cart_path
    end
  end

  private
  def order_products_params
    params.require(:order_products).permit(:quantity, :order_id, :product_id)
  end
end
