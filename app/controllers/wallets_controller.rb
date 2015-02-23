class WalletsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource


  def show
    @wallet = Wallet.find(params[:user_id])
  end

  def new
    @email = current_user.email
    @wallet = Wallet.find_by_email(@email)
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
    @wallet = Wallet.find_by_email(current_user.email).
    authorize! :edit, @wallet
  end

  def update
    @wallet = Wallet.find_by_email(current_user.email)
    @wallet.update_attributes(wallet_params)
    redirect_to budgets_url
  end

private

  def wallet_params
    params.require(:wallet).permit(:email, :income, :expense).merge(email: current_user.email)
  end
end
