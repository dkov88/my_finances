class WalletsController < ApplicationController

  load_and_authorize_resource except: [:create]
  before_filter :authenticate_user!
  
  before_action :find, only: [:new, :update, :edit, :destroy]


  def show
    @wallet = Wallet.find(params[:user_id])
  end

  def new
    unless @wallet 
      @wallet = Wallet.new
    else
     redirect_to budgets_url
    end
  end

  def create
    @wallet = Wallet.create(wallet_params)
    redirect_to budgets_url
  end

  def edit
    authorize! :edit, @wallet
  end

  def update
    @wallet.update_attributes(wallet_params)
    redirect_to budgets_url
  end

  def destroy
    authorize! :destroy, @wallet
    @wallet.budgets.destroy_all
    @wallet.destroy
    redirect_to root_path
  end

private

  def wallet_params
    params.require(:wallet).permit(:email, :income, :expense).merge(email: current_user.email)
  end

  def find
    @wallet = Wallet.find_by_email(current_user.email)
  end
end
