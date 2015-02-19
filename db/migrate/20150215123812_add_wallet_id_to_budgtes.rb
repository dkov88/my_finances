class AddWalletIdToBudgtes < ActiveRecord::Migration
  def change
    add_column :budgets, :wallet_id, :integer
  end
end
