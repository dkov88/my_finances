class BudgetsController < ApplicationController
  respond_to :html, :js

   before_filter :authenticate_user!
  def index
    @budgets = Budget.accessible_by(current_ability)
  end

  def new
    @budget = Budget.new
  end

  def create
    @budgets = Budget.accessible_by(current_ability)
    @budget = Budget.create(budget_params)
  end

  def edit
    @budget = Budget.find(params[:id])
  end

  def update
    @budgets = Budget.accessible_by(current_ability)
    @budget = Budget.find(params[:id])
    
    @budget.update_attributes(budget_params)
  end

  def delete
    @budget = Budget.find(params[:budget_id])
  end

  def destroy
    @budgets = Budget.all
    @budget = Budget.find(params[:id])
    @budget.destroy
  end


private

  def budget_params
    params.require(:budget).permit(:description, :amount, :date, :money_kind).merge(user_id: current_user.id)
  end
end
