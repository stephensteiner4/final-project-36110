# == Schema Information
#
# Table name: production_plans
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class ProductionPlan < ApplicationRecord
  has_many  :fixed_costs, class_name: "OverheadExpense", foreign_key: "plan_id", dependent: :destroy
end
