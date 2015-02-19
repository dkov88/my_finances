class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.string :email
      t.boolean :income
      t.boolean :expense

      t.timestamps null: false
    end
  end
end
