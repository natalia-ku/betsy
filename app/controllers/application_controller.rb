class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user


    def current_order
      if !session[:order_id].nil?
        order = Order.find(session[:order_id])
      else
        order = Order.create(status: "pending", email: "", mailing_address: "",  card_name: "",credit_card: 0, cvv: 0,zip_code: 0, paid_at: DateTime.now)
        session[:order_id] = order.id
      end
      return order
    end

  private
  def find_user
    if session[:user_id]
      @current_user = Merchant.find_by(id: session[:user_id])
    end
  end


end
