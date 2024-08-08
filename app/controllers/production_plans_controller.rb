class ProductionPlansController < ApplicationController
  def index
    matching_production_plans = ProductionPlan.all

    if current_user != nil

      @list_of_production_plans = matching_production_plans.order({ :created_at => :desc }).where({:user_id => current_user.id})

      render({ :template => "production_plans/index" })

    elsif

      render({ :template => "production_plans/force_sign_in" })
    
    end
  end

  def show
    the_id = params.fetch("path_id")

    matching_production_plans = ProductionPlan.where({ :id => the_id })

    @the_production_plan = matching_production_plans.at(0)

    @fixed_per_sqftweek = (@the_production_plan.fixed_costs.pluck(:total_cost).sum / (@the_production_plan.total_space*52)).round(2)

    render({ :template => "production_plans/show" })
  end

  def create
    the_production_plan = ProductionPlan.new
    the_production_plan.name = params.fetch("query_name")
    the_production_plan.description = params.fetch("query_description")
    the_production_plan.user_id = params.fetch("query_user_id")
    the_production_plan.total_space = params.fetch("query_space")
    the_production_plan.soil_cost = params.fetch("query_soil")

    if the_production_plan.valid?
      the_production_plan.save
      redirect_to("/production_plans", { :notice => "Production plan created successfully." })
    else
      redirect_to("/production_plans", { :alert => the_production_plan.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_production_plan = ProductionPlan.where({ :id => the_id }).at(0)

    the_production_plan.description = params.fetch("query_description")
    the_production_plan.user_id = params.fetch("query_user_id")
    the_production_plan.total_space = params.fetch("query_space")
    the_production_plan.soil_cost = params.fetch("query_soil")

    if the_production_plan.valid?
      the_production_plan.save
      redirect_to("/production_plans/#{the_production_plan.id}", { :notice => "Production plan updated successfully."} )
    else
      redirect_to("/production_plans/#{the_production_plan.id}", { :alert => the_production_plan.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_production_plan = ProductionPlan.where({ :id => the_id }).at(0)

    the_production_plan.destroy

    redirect_to("/production_plans", { :notice => "Production plan deleted successfully."} )
  end
end
