class AddNameToProductionPlan < ActiveRecord::Migration[7.1]
  def change
    add_column :production_plans, :name, :string
  end
end
