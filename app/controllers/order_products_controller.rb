class OrderProductsController < ApplicationController
  def new
    @order_product = OrderProduct.new
  end

  def create
    @current_order = current_order
    @order_product = OrderProduct.new(quantity: params[:quantity], order_id: @current_order.id, product_id: params[:product_id])
    if @order_product.save!
      redirect_to shopping_cart_path
      flash[:success] = "You successfully added #{@order_product.product.name} to the cart"
    else
      redirect_to product_path(@order_product.product_id)
    end
  end

  def index
    @order_products = OrderProduct.all
  end

  def update #updating quantity in shopping cart
    @order = current_order
    @order_product = OrderProduct.find(params[:id])
    @order_product.quantity = params[:quantity].to_i
    if @order_product.save
      redirect_to shopping_cart_path
    end
  end



  def ship
    @order_product = OrderProduct.find(params[:id])

    if @order_product.order.status != "paid"
      flash[:message] = "You cannot ship this product, since order status is #{@order_product.order.status}"
      redirect_to merchant_order_view_path(@order_product.product.merchant_id  , @order_product.order_id )
      return
    end



    @order_product.status = "shipped"

    if @order_product.save
      flash[:success] = "You successfully shipped this product"
      redirect_to merchant_order_view_path(@order_product.product.merchant_id  , @order_product.order_id )
    end

    order = @order_product.order
    order.complete?
    #complete? is a method in orders controller
    end

    # number_shipped = 0
    #
    # order.order_products.each do |op|
    #   if op.status == "shipped"
    #     number_shipped += 1
    #   end
    # end
    # if number_shipped == order.order_products.count
    #   order.status = "complete"
    #   order.save
    # end
    #end





  def destroy # deletes order products from shopping cart
    @order = current_order
    @order_product = OrderProduct.find(params[:id])
    if @order_product.destroy
      if destroy_whole_order?(@order)
        @order.destroy
        session[:order_id] = nil
      end
      flash[:success] = "You successfully deleted #{@order_product.product.name} from the shopping cart"
      redirect_to shopping_cart_path
    end
  end

  private

  def order_products_params
    params.require(:order_products).permit(:quantity, :order_id, :product_id)
  end

  def destroy_whole_order?(order)
    destroy_order = true # delete whole order if shopping cart is empty
    order.order_products.each do |op|
      destroy_order = false if op != nil
    end
    return destroy_order
  end

end
