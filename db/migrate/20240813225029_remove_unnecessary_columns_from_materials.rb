class RemoveUnnecessaryColumnsFromMaterials < ActiveRecord::Migration[7.1]
  def change
    remove_column :materials, :retail_week

    remove_column :materials, :unit_margin

    remove_column :materials, :sqft_margin
  end
end
