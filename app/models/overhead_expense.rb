# == Schema Information
#
# Table name: overhead_expenses
#
#  id         :bigint           not null, primary key
#  category   :string
#  total_cost :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :integer
#  user_id    :integer
#
class OverheadExpense < ApplicationRecord

  # has_many  :fixed_costs, class_name: "OverheadExpense", foreign_key: "plan_id", dependent: :destroy
  belongs_to :plan, class_name: "ProductionPlan", foreign_key: "plan_id"
  belongs_to :user, class_name: "User", foreign_key: "user_id"

  ### Validation
  validates :category, :total_cost, :plan_id, :user_id, presence: true
  
  validates :total_cost, numericality: true

  validates :plan_id, :user_id, numericality: { only_integer: true }
end
