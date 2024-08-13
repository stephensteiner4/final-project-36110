class RemoveDirectCostsFromOverheadExpenses < ActiveRecord::Migration[7.1]
  def change
    remove_column :overhead_expenses, :direct_cost
  end
end
