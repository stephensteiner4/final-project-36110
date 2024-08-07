# == Schema Information
#
# Table name: greenhouse_utilizations
#
#  id               :bigint           not null, primary key
#  time             :integer
#  total_benchspace :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  plan_id          :integer
#  user_id          :integer
#
class GreenhouseUtilization < ApplicationRecord
  belongs_to :grower, required: true, class_name: "ProductionPlan", foreign_key: "plan_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
end
