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

  def update #order completed
    @order = current_order

    # @order.update_attributes(order_params) # NOT WORKING!!!
    @order.email = params[:email]
    @order.mailing_address = params[:mailing_address]
    @order.card_name = params[:card_name]
    @order.credit_card = params[:credit_card]
    @order.cvv = params[:cvv]
    @order.zip_code = params[:zip_code]
    @order.status = "completed"
    @order.paid_at = @order.updated_at
    if @order.save!
      flash[:success] = "You successfully created your order"
      redirect_to order_path(@order.id)
      session[:order_id] = nil
    else
      render :edit
    end
  end

  def destroy
    current_order.order_products.each do |op|
      op.destroy
    end
    current_order.destroy
    session[:order_id] = nil
    redirect_to products_path
  end

  private
  def order_params
    params.require(:order_params).permit(:status, :email, :mailing_address,:card_name, :credit_card, :cvv, :zip_code, :paid_at)
  end
end
