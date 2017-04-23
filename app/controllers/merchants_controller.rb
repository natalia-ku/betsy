class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    @merchant.save
    # flash[:success] = "User added successfully"
    # session[:user_id] = @user.id
    # session[:username] = @user.name
    # flash[:success] = "Successfully logged in as user #{@user.name} "
    #   redirect_to root_path
    # else
    #   # flash.now[:failure] = "User did not save, try again"
    #   # render :new, status: :bad_request
    # end
  end
  private
  def merchant_params
    params.require(:merchant).permit(:username, :email_address)
  end
end
