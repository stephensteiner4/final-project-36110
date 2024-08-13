# == Schema Information
#
# Table name: production_plans
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  prod_weeks  :integer
#  soil_cost   :float
#  total_space :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class ProductionPlan < ApplicationRecord
  # has_many  :fixed_costs, class_name: "OverheadExpense", foreign_key: "plan_id", dependent: :destroy
  has_many :fixed_costs, class_name: "OverheadExpense", foreign_key: "plan_id", dependent: :destroy
  belongs_to :grower, required: true, class_name: "User", foreign_key: "user_id"
  has_many  :crops, class_name: "Material", foreign_key: "plan_id", dependent: :destroy
end
