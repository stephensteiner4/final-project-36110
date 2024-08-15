class MaterialsController < ApplicationController

  def show
    the_id = params.fetch("path_id")

    matching_materials = Material.where({ :id => the_id })

    if matching_materials.at(0).user_id == current_user.id
      @the_material = matching_materials.at(0)

      render({ :template => "materials/show" })
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end

  end

  def create
    the_material = Material.new
    
    the_material.user_id = current_user.id
    the_material.plan_id = params.fetch("query_plan_id").to_i

    check_prodplan = ProductionPlan.where({:id => the_material.plan_id}).at(0)

    if check_prodplan.user_id == current_user.id
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

      diam = the_material.container_size
      
      if the_material.container_type == "Pot"
        the_material.bench_space = ((diam**2/144.0) * the_material.total_qty).round(2)
      elsif the_material.container_type == "Tray"
        the_material.bench_space = (((11*22)/144.0) * (the_material.total_qty / diam)).round(2)
      end

      the_material.total_bench_space_weeks = the_material.bench_space * the_material.crop_time
      prodplan = ProductionPlan.where({:id=>params.fetch("query_plan_id").to_i}).at(0)

      if the_material.container_type == "Pot"
        the_material.soil_cost = (((3.14 * ((diam/2)**2) * diam) / 46656.0) * prodplan.soil_cost).round(2)
      elsif matl.container_type == "Tray"
        cell_volume = Math.sqrt((11*22.0)/diam)**3

        matl.soil_cost = ((cell_volume / 46656) * prodplan.soil_cost).round(2)
      end
      
      the_material.shrink_opportunity_cost = ((the_material.buffer/100.0) * the_material.unit_price).round(2)

      the_material.unit_cost = the_material.shrink_opportunity_cost + the_material.unit_container_cost + the_material.unit_tag_cost + the_material.material_cost + the_material.soil_cost

      the_material.total_cost = the_material.unit_cost * the_material.total_qty
      the_material.total_revenue = the_material.unit_price * the_material.total_qty

      if the_material.valid?
        the_material.save
        redirect_to("/production_plans/#{the_material.plan_id}", { :notice => "Material created successfully." })
      else
        redirect_to("/production_plans/#{the_material.plan_id}", { :alert => the_material.errors.full_messages.to_sentence })
      end
    else
      redirect_to("/production_plans")
    end
  end

  def copy
    the_id = params.fetch("path_id")
    the_material = Material.where({ :id => the_id }).at(0)

    if the_material.user_id == current_user.id

      the_material2 = the_material.dup

      if the_material2.valid?
        the_material2.save
        
        redirect_to("/production_plans/#{the_material.plan_id}", { :notice => "Material copied successfully." })
      else
        redirect_to("/production_plans/#{the_material.plan_id}", { :alert => the_material.errors.full_messages.to_sentence })
      end
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end

  end

  def update
    the_id = params.fetch("path_id")
    the_material = Material.where({ :id => the_id }).at(0)

    if the_material.user_id == current_user.id
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
      
      the_material.user_id = current_user.id
      the_material.plan_id = the_material.plan_id

      diam = the_material.container_size
      
      the_material.bench_space = ((diam**2/144.0) * the_material.total_qty).round(2)
      the_material.total_bench_space_weeks = the_material.bench_space * the_material.crop_time
      prodplan = ProductionPlan.where({:id=>the_material.plan_id}).at(0)

      if the_material.container_type == "Pot"
        the_material.soil_cost = (((3.14 * ((diam/2)**2) * diam) / 46656.0) * prodplan.soil_cost).round(2)
      elsif the_material.container_type == "Tray"
        cell_volume = Math.sqrt((11*22.0)/diam)**3

        the_material.soil_cost = ((cell_volume / 46656) * prodplan.soil_cost).round(2)
      end
      
      the_material.shrink_opportunity_cost = ((the_material.buffer/100.0) * the_material.unit_price).round(2)

      the_material.unit_cost = the_material.shrink_opportunity_cost + the_material.unit_container_cost + the_material.unit_tag_cost + the_material.material_cost + the_material.soil_cost

      the_material.total_cost = the_material.unit_cost * the_material.total_qty
      the_material.total_revenue = the_material.unit_price * the_material.total_qty

      if the_material.valid?
        the_material.save
        redirect_to("/production_plans/#{the_material.plan_id}", { :notice => "Material updated successfully."} )
      else
        redirect_to("/materials/#{the_material.id}", { :alert => the_material.errors.full_messages.to_sentence })
      end
    
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_material = Material.where({ :id => the_id }).at(0)
    
    if the_material.user_id == current_user.id
      the_material.destroy

      redirect_to("/production_plans/#{the_material.plan_id}", { :notice => "Material deleted successfully."} )
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end
  end
end
