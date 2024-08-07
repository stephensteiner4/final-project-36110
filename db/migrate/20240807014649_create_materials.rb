class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.string :description
      t.integer :crop_time
      t.integer :plan_id
      t.float :material_cost
      t.integer :retail_week
      t.integer :container_size
      t.float :soil_cost
      t.float :unit_price
      t.string :unit_margin
      t.float :buffer
      t.float :bench_space
      t.float :unit_cost
      t.float :sqft_cost
      t.integer :user_id
      t.float :sqft_margin
      t.string :container_type
      t.float :unit_container_cost
      t.float :unit_tag_cost

      t.timestamps
    end
  end
end
