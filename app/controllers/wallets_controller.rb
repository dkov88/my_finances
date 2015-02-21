class WalletsController < ApplicationController

  before_filter :authenticate_user!

  def show
    @wallet = Wallet.find(params[:user_id])
  end

  def new
    @email = current_user.email
    @wallets = Wallet.find_by_email(@email)
    unless @wallets 
      @wallet = Wallet.new
    else
     redirect_to budgets_url
    end
  end

  def create
    @wallet = Wallet.create(wallet_params)
    redirect_to budgets_url
  end

private

  def wallet_params
    params.require(:wallet).permit(:email, :income, :expense).merge(email: current_user.email)
  end
end
