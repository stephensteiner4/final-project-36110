class AddMiscellaneousToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :miscellaneous, :float
  end
end
