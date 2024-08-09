# == Schema Information
#
# Table name: materials
#
#  id                      :bigint           not null, primary key
#  bench_space             :float
#  buffer                  :float
#  container_size          :integer
#  container_type          :string
#  crop_time               :integer
#  description             :string
#  material_cost           :float
#  miscellaneous           :float
#  retail_week             :integer
#  shrink_opportunity_cost :float
#  soil_cost               :float
#  sqft_cost               :float
#  sqft_margin             :float
#  total_cost              :float
#  total_qty               :float
#  total_revenue           :float
#  unit_container_cost     :float
#  unit_cost               :float
#  unit_margin             :string
#  unit_price              :float
#  unit_tag_cost           :float
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  plan_id                 :integer
#  user_id                 :integer
#
class Material < ApplicationRecord
  belongs_to :grower, required: true, class_name: "ProductionPlan", foreign_key: "plan_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
end
