class CreateOverheadExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :overhead_expenses do |t|
      t.string :category
      t.string :total_cost
      t.integer :plan_id
      t.integer :user_id

      t.timestamps
    end
  end
end
