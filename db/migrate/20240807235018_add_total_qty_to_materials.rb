class AddTotalQtyToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :total_qty, :float
  end
end
