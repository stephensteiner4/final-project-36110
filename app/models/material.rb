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
#  shrink_opportunity_cost :float
#  soil_cost               :float
#  sqft_cost               :float
#  total_bench_space_weeks :float
#  total_cost              :float
#  total_qty               :float
#  total_revenue           :float
#  unit_container_cost     :float
#  unit_cost               :float
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

  ### Validation
  validates :bench_space, :buffer, :container_size, :container_type, :crop_time, :description, :material_cost, :miscellaneous, :shrink_opportunity_cost, :soil_cost, :sqft_cost, :total_bench_space_weeks, :total_cost, :total_qty, :total_revenue, :unit_container_cost, :unit_cost, :unit_price, :unit_tag_cost, :plan_id, :user_id, presence: true
  
  validates :bench_space, :buffer, :material_cost, :miscellaneous, :shrink_opportunity_cost, :soil_cost, :sqft_cost, :total_bench_space_weeks, :total_cost, :total_qty, :total_revenue, :unit_container_cost, :unit_cost, :unit_price, :unit_tag_cost, numericality: true
  
  validates :container_size, :crop_time, :plan_id, :user_id, numericality: { only_integer: true }
end
