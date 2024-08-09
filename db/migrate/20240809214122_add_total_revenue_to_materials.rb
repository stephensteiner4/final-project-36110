class AddTotalRevenueToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :total_revenue, :float
  end
end
