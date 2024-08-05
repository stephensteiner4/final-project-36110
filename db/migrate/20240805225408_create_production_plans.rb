class CreateProductionPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :production_plans do |t|
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
