class AddTotalBenchSpaceWeeksToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :total_bench_space_weeks, :float
  end
end
