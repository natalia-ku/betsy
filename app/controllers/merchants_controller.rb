class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    if @merchant.nil?
      head :not_found
    end
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to merchants_path
    end

  end
  private
  def merchant_params
    params.require(:merchant).permit(:username, :email)
  end
end
