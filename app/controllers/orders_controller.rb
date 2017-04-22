class OrdersController < ApplicationController
  before_action :create_order, only: [:new, :create]
  before_action :find_current_order, only:[:shopping_cart, :edit, :update]
  def index
    @orders = Order.all
  end

  def new
  end

  def create
    if @order.save
      redirect_to send(:back)
    end
  end

  def shopping_cart
    @shopping_cart_products = OrderProduct.all.where(order_id: @order.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
  end

  def update #make  pending order paid or cancelled
    @order.update_attributes(order_update_params)
    if params[:paid_order]
      @order.status = "paid"
      # Remove items from stock:
      order_products = OrderProduct.where(order_id: @order.id)
      order_products.each do |op|
        op.product.stock -= op.quantity
        op.product.save
      end
    elsif params[:cancel_order]
      @order.status = "cancelled"
    end
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
  def order_update_params
    params.require(:order).permit(:email, :mailing_address,:card_name, :credit_card, :cvv, :zip_code)
  end

  def order_params
    params.require(:order).permit(:status, :email, :mailing_address,:card_name, :credit_card, :cvv, :zip_code, :paid_at)
  end

  def create_order
    @order = Order.new(order_params)
  end

  def find_current_order
    @order = current_order
  end
end
