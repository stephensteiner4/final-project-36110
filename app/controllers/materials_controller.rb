class MaterialsController < ApplicationController
  def index
    matching_materials = Material.all

    @list_of_materials = matching_materials.order({ :created_at => :desc })

    render({ :template => "materials/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_materials = Material.where({ :id => the_id })

    @the_material = matching_materials.at(0)

    render({ :template => "materials/show" })
  end

  def create
    the_material = Material.new
    the_material.description = params.fetch("query_description")
    the_material.crop_time = params.fetch("query_crop_time")
    the_material.container_type = params.fetch("query_container_type")
    the_material.container_size = params.fetch("query_container_size")
    the_material.total_qty = params.fetch("query_total_qty")

    the_material.material_cost = params.fetch("query_material_cost")
    the_material.unit_container_cost = params.fetch("query_unit_container_cost")
    the_material.unit_tag_cost = params.fetch("query_unit_tag_cost")
    the_material.miscellaneous = params.fetch("query_miscellaneous")
    
    the_material.buffer = params.fetch("query_buffer")
    
    the_material.unit_price = params.fetch("query_unit_price")
    
    the_material.user_id = params.fetch("query_user_id").to_i
    the_material.plan_id = params.fetch("query_plan_id").to_i

    diam = the_material.container_size
    
    the_material.bench_space = ((diam**2/144.0) * the_material.total_qty).round(2)
    prodplan = ProductionPlan.where({:id=>params.fetch("query_plan_id").to_i}).at(0)

    if the_material.container_type == "Pot"
      the_material.soil_cost = (((3.14 * ((diam/2)**2) * diam) / 46656.0) * prodplan.soil_cost).round(2)
    end
    
    the_material.shrink_opportunity_cost = ((the_material.buffer/100.0) * the_material.unit_price).round(2)

    if the_material.valid?
      the_material.save
      redirect_to("/production_plans/#{the_material.plan_id}", { :notice => "Material created successfully." })
    else
      redirect_to("/production_plans/#{the_material.plan_id}", { :alert => the_material.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_material = Material.where({ :id => the_id }).at(0)

    the_material.description = params.fetch("query_description")
    the_material.crop_time = params.fetch("query_crop_time")
    the_material.plan_id = params.fetch("query_plan_id")
    the_material.material_cost = params.fetch("query_material_cost")
    the_material.retail_week = params.fetch("query_retail_week")
    the_material.container_size = params.fetch("query_container_size")
    the_material.soil_cost = params.fetch("query_soil_cost")
    the_material.unit_price = params.fetch("query_unit_price")
    the_material.unit_margin = params.fetch("query_unit_margin")
    the_material.buffer = params.fetch("query_buffer")
    the_material.bench_space = params.fetch("query_bench_space")
    the_material.unit_cost = params.fetch("query_unit_cost")
    the_material.sqft_cost = params.fetch("query_sqft_cost")
    the_material.user_id = params.fetch("query_user_id")
    the_material.sqft_margin = params.fetch("query_sqft_margin")
    the_material.container_type = params.fetch("query_container_type")
    the_material.unit_container_cost = params.fetch("query_unit_container_cost")
    the_material.unit_tag_cost = params.fetch("query_unit_tag_cost")

    if the_material.valid?
      the_material.save
      redirect_to("/materials/#{the_material.id}", { :notice => "Material updated successfully."} )
    else
      redirect_to("/materials/#{the_material.id}", { :alert => the_material.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_material = Material.where({ :id => the_id }).at(0)

    the_material.destroy

    redirect_to("/materials", { :notice => "Material deleted successfully."} )
  end
end
