class OrderProductsController < ApplicationController
  def new
    @order_product = OrderProduct.new
  end

  def create
    @order_product = OrderProduct.new(quantity: params[:quantity], order_id: params[:order_id], product_id: params[:product_id])
    @order_product.product.stock = @order_product.product.stock - params[:quantity].to_i
    @order_product.quantity = params[:quantity].to_i

    @order_product.product.save
    @order_product.save
    redirect_to shopping_cart_path
  end

  def index
    @order_products = OrderProduct.all
  end

  def update #update quantity
    @order = current_order
    @order_product = OrderProduct.find(params[:id])

    @order_product.product.stock = @order_product.product.stock + @order_product.quantity - params[:quantity].to_i
    @order_product.quantity = params[:quantity].to_i

    @order_product.product.save
    @order_product.save
    redirect_to shopping_cart_path
  end


  def destroy
    @order = current_order
    @order_product = OrderProduct.find(params[:id])
    @order_product.product.stock += @order_product.quantity #when deleting product from cart need to update product stock back
    @order_product.destroy
    redirect_to shopping_cart_path
  end

  private
  def order_products_params
    params.require(:order_products_params).permit(:quantity, :order_id, :product_id)
  end
end
