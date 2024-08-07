class GreenhouseUtilizationsController < ApplicationController
  def index
    matching_greenhouse_utilizations = GreenhouseUtilization.all

    @list_of_greenhouse_utilizations = matching_greenhouse_utilizations.order({ :created_at => :desc })

    render({ :template => "greenhouse_utilizations/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_greenhouse_utilizations = GreenhouseUtilization.where({ :id => the_id })

    @the_greenhouse_utilization = matching_greenhouse_utilizations.at(0)

    render({ :template => "greenhouse_utilizations/show" })
  end

  def create
    the_greenhouse_utilization = GreenhouseUtilization.new
    the_greenhouse_utilization.time = params.fetch("query_time")
    the_greenhouse_utilization.total_benchspace = params.fetch("query_total_benchspace")
    the_greenhouse_utilization.plan_id = params.fetch("query_plan_id")
    the_greenhouse_utilization.user_id = params.fetch("query_user_id")

    if the_greenhouse_utilization.valid?
      the_greenhouse_utilization.save
      redirect_to("/greenhouse_utilizations", { :notice => "Greenhouse utilization created successfully." })
    else
      redirect_to("/greenhouse_utilizations", { :alert => the_greenhouse_utilization.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_greenhouse_utilization = GreenhouseUtilization.where({ :id => the_id }).at(0)

    the_greenhouse_utilization.time = params.fetch("query_time")
    the_greenhouse_utilization.total_benchspace = params.fetch("query_total_benchspace")
    the_greenhouse_utilization.plan_id = params.fetch("query_plan_id")
    the_greenhouse_utilization.user_id = params.fetch("query_user_id")

    if the_greenhouse_utilization.valid?
      the_greenhouse_utilization.save
      redirect_to("/greenhouse_utilizations/#{the_greenhouse_utilization.id}", { :notice => "Greenhouse utilization updated successfully."} )
    else
      redirect_to("/greenhouse_utilizations/#{the_greenhouse_utilization.id}", { :alert => the_greenhouse_utilization.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_greenhouse_utilization = GreenhouseUtilization.where({ :id => the_id }).at(0)

    the_greenhouse_utilization.destroy

    redirect_to("/greenhouse_utilizations", { :notice => "Greenhouse utilization deleted successfully."} )
  end
end
