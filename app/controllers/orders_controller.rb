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
end
