# == Schema Information
#
# Table name: production_plans
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class ProductionPlan < ApplicationRecord
end
