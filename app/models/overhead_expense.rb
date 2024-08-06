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

  has_many  :fixed_costs, class_name: "OverheadExpense", foreign_key: "plan_id", dependent: :destroy

end
