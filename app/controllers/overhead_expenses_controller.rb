class OverheadExpensesController < ApplicationController

  def show
    the_id = params.fetch("path_id")

    matching_overhead_expenses = OverheadExpense.where({ :id => the_id })

    if matching_overhead_expenses.at(0).user_id == current_user.id
      @the_overhead_expense = matching_overhead_expenses.at(0)

      render({ :template => "overhead_expenses/show" })
    else
      redirect_to("/production_plans", {:notice=>"You don't have access to that page."})
    end

  end

  def create
    the_overhead_expense = OverheadExpense.new
    the_overhead_expense.plan_id = params.fetch("query_plan_id")

    check_prodplan = ProductionPlan.where({:id => the_overhead_expense.plan_id}).at(0)

    if check_prodplan.user_id == current_user.id
      the_overhead_expense.category = params.fetch("query_category")
      the_overhead_expense.total_cost = params.fetch("query_total_cost")
      the_overhead_expense.user_id = current_user.id

      if the_overhead_expense.valid?
        the_overhead_expense.save
        redirect_to("/production_plans/#{the_overhead_expense.plan_id}", { :notice => "Overhead expense created successfully." })
      else
        redirect_to("/production_plans/#{the_overhead_expense.plan_id}", { :alert => the_overhead_expense.errors.full_messages.to_sentence })
      end
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_overhead_expense = OverheadExpense.where({ :id => the_id }).at(0)
    
    if the_overhead_expense.user_id == current_user.id

      the_overhead_expense.category = params.fetch("query_category")
      the_overhead_expense.total_cost = params.fetch("query_total_cost")
      the_overhead_expense.plan_id = the_overhead_expense.plan_id
      the_overhead_expense.user_id = current_user.id

      if the_overhead_expense.valid?
        the_overhead_expense.save
        redirect_to("/production_plans/#{the_overhead_expense.plan_id}", { :notice => "Overhead expense updated successfully."} )
      else
        redirect_to("/overhead_expenses/#{the_overhead_expense.id}", { :alert => the_overhead_expense.errors.full_messages.to_sentence })
      end
    else
      redirect_to("/", {:notice=>"You don't have access to that page."})
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_overhead_expense = OverheadExpense.where({ :id => the_id }).at(0)

    if the_overhead_expense.user_id == current_user.id
      the_overhead_expense.destroy

      redirect_to("/production_plans/#{the_overhead_expense.plan_id}", { :notice => "Overhead expense deleted successfully."} )
    else
      redirect_to("/production_plans", {:notice => "You don't have access to that page."})
    end
  end
end
