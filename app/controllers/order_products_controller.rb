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
end
