class AddProdWeeksToProductionPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :production_plans, :prod_weeks, :integer
  end
end
