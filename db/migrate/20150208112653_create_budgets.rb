class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.text :description
      t.decimal :amount
      t.string :money_kind
      t.datetime :date

      t.timestamps null: false
    end
  end
end
