class AddDirectCostToOverheadExpense < ActiveRecord::Migration[7.1]
  def change
    add_column :overhead_expenses, :direct_cost, :string
  end
end
