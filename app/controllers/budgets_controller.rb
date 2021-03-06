class BudgetsController < ApplicationController
  respond_to :html, :js

   before_filter :authenticate_user!
   before_action :get_wallets, only: [:index, :update, :create, :destroy]

  def index
    filtering_params(params).each do |key, value|
      @budgets = @budgets.public_send(key, value) if value.present?
    end
    @wallet_id = Wallet.find_by_email(current_user.email).id
  end

  def new
    @budget = Budget.new
    @type = budget_type
  end

  def create
    @budget = Budget.create(budget_params)

  end

  def edit
    @type = budget_type
    @budget = Budget.find(params[:id])
  end

  def update
    @budget = Budget.find(params[:id])
    
    @budget.update_attributes(budget_params)
  end

  def delete
    @budget = Budget.find(params[:budget_id])
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
  end


private

  def budget_params
    wallet_id = Wallet.find_by_email(current_user.email).id
    params.require(:budget).permit(:description, :amount, :date, :money_kind).merge(wallet_id: wallet_id)
  end

  def get_wallets
    wallet_id = Wallet.find_by_email(current_user.email).id
    @budgets = Budget.where(wallet_id: wallet_id).paginate(:page => params[:page], :per_page => 8).order('date DESC')
  end

  def filtering_params(params)
    params.slice(:description, :money_kind, :start_date, :end_date)
  end


  def budget_type
    wallet = Wallet.find_by_email(current_user.email)
    array ||= []
    array << ['income', 'income'] if (wallet.income == true)
    array << ['expense', 'expense'] if (wallet.expense == true)
    return array
  end

end
