class ChangeTotalCostTypeToDecimal < ActiveRecord::Migration[7.1]
  def change
    change_column :overhead_expenses, :total_cost, 'decimal USING CAST(total_cost AS decimal)'
  end
end
