class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end
  def new
    @order = Order.new(order_params)
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to send(:back)
    end
  end

  def shopping_cart
    @order = current_order
    @shopping_cart_products = OrderProduct.all.where(order_id: @order.id)
    #@shopping_cart_products = OrderProduct.all.where(status???)
  end

  # def paid_order # when user clicks pay button in the checkout
  #   @order.status = "paid"
  # end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = current_order
  end




  
end
