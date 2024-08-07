class CreateGreenhouseUtilizations < ActiveRecord::Migration[7.1]
  def change
    create_table :greenhouse_utilizations do |t|
      t.integer :time
      t.float :total_benchspace
      t.integer :plan_id
      t.integer :user_id

      t.timestamps
    end
  end
end
