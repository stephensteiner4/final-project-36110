class AddTotalAvailableSpaceToProductionPlan < ActiveRecord::Migration[7.1]
  def change
    add_column :production_plans, :total_space, :decimal
  end
end
