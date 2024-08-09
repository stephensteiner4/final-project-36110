class AddTotalCostToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :total_cost, :float
  end
end
