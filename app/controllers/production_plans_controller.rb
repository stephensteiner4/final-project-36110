class ProductionPlansController < ApplicationController
  def index
    matching_production_plans = ProductionPlan.all

    if current_user != nil

      @list_of_production_plans = matching_production_plans.order({ :created_at => :desc }).where({:user_id => current_user.id})

      render({ :template => "production_plans/index" })

    else

      render({ :template => "production_plans/force_sign_in" })
    
    end
  end

  def show
    the_id = params.fetch("path_id")

    matching_production_plans = ProductionPlan.where({ :id => the_id })

    if matching_production_plans.at(0).user_id == current_user.id
      @the_production_plan = matching_production_plans.at(0)

      @fixed_per_sqftweek = (@the_production_plan.fixed_costs.pluck(:total_cost).sum / (@the_production_plan.total_space*52)).round(2)

      @used_space = (@the_production_plan.crops.pluck(:total_bench_space_weeks).sum / (@the_production_plan.total_space * @the_production_plan.prod_weeks)).round(3)*100

      render({ :template => "production_plans/show" })
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end
  end

  def create
    the_production_plan = ProductionPlan.new
    the_production_plan.name = params.fetch("query_name")
    the_production_plan.description = params.fetch("query_description")
    the_production_plan.user_id = current_user.id
    the_production_plan.prod_weeks = params.fetch("query_prodweeks")
    the_production_plan.total_space = params.fetch("query_space")
    the_production_plan.soil_cost = params.fetch("query_soil")

    if the_production_plan.valid?
      the_production_plan.save
      redirect_to("/production_plans", { :notice => "Production plan created successfully." })
    else
      redirect_to("/production_plans", { :alert => the_production_plan.errors.full_messages.to_sentence })
    end
  end

  def copy
    the_id = params.fetch("path_id")
    the_production_plan = ProductionPlan.where({ :id => the_id }).at(0)

    if the_production_plan.user_id == current_user.id

      ### Copy Production Plan
      the_production_plan2 = the_production_plan.dup

      the_production_plan2.name = the_production_plan2.name + " - Copy"

      if the_production_plan2.valid?
        the_production_plan2.save

        redirect_to("/production_plans", { :notice => "Production plan copied successfully." })
      else
        redirect_to("/production_plans", { :alert => the_production_plan.errors.full_messages.to_sentence })
      end

      ### Copy Materials
      the_production_matls = Material.where({ :plan_id => the_id })

      the_production_matls.each do |matl|
        matl2 = matl.dup

        matl2.plan_id = the_production_plan2.id

        if matl2.valid?
          matl2.save
        else
          redirect_to("/production_plans", { :alert => the_production_plan.errors.full_messages.to_sentence })
        end
      end
      
      ### Copy Fixed Costs
      the_production_fixed = OverheadExpense.where({ :plan_id => the_id })

      the_production_fixed.each do |fix|
        fix2 = fix.dup

        fix2.plan_id = the_production_plan2.id

        if fix2.valid?
          fix2.save
        else
          redirect_to("/production_plans", { :alert => the_production_plan.errors.full_messages.to_sentence })
        end


      end
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end
    
  end

  def update
    the_id = params.fetch("path_id")
    the_production_plan = ProductionPlan.where({ :id => the_id }).at(0)

    if the_production_plan.user_id == current_user.id
      the_production_plan.description = params.fetch("query_description")
      the_production_plan.user_id = current_user.id
      the_production_plan.prod_weeks = params.fetch("query_prodweeks")
      the_production_plan.total_space = params.fetch("query_space")
      the_production_plan.soil_cost = params.fetch("query_soil")

      if the_production_plan.valid?
        the_production_plan.save
        redirect_to("/production_plans/#{the_production_plan.id}", { :notice => "Production plan updated successfully."} )
      else
        redirect_to("/production_plans/#{the_production_plan.id}", { :alert => the_production_plan.errors.full_messages.to_sentence })
      end
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_production_plan = ProductionPlan.where({ :id => the_id }).at(0)

    if the_production_plan.user_id == current_user.id

      the_production_plan.destroy

      redirect_to("/production_plans", { :notice => "Production plan deleted successfully."} )
    
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end

  end
end
