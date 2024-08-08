class AddSoilCostToProductionPlan < ActiveRecord::Migration[7.1]
  def change
    add_column :production_plans, :soil_cost, :float
  end
end
