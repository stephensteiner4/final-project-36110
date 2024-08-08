class AddShrinkOpportunityCostToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :shrink_opportunity_cost, :float
  end
end
