class OverheadExpensesController < ApplicationController
  def index
    matching_overhead_expenses = OverheadExpense.all

    @list_of_overhead_expenses = matching_overhead_expenses.order({ :created_at => :desc })

    render({ :template => "overhead_expenses/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_overhead_expenses = OverheadExpense.where({ :id => the_id })

    @the_overhead_expense = matching_overhead_expenses.at(0)

    render({ :template => "overhead_expenses/show" })
  end

  def create
    the_overhead_expense = OverheadExpense.new
    the_overhead_expense.category = params.fetch("query_category")
    the_overhead_expense.total_cost = params.fetch("query_total_cost")
    the_overhead_expense.plan_id = params.fetch("query_plan_id")
    the_overhead_expense.user_id = params.fetch("query_user_id")

    if the_overhead_expense.valid?
      the_overhead_expense.save
      redirect_to("/production_plans/#{the_overhead_expense.plan_id}", { :notice => "Overhead expense created successfully." })
    else
      redirect_to("/production_plans/#{the_overhead_expense.plan_id}", { :alert => the_overhead_expense.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_overhead_expense = OverheadExpense.where({ :id => the_id }).at(0)

    the_overhead_expense.category = params.fetch("query_category")
    the_overhead_expense.total_cost = params.fetch("query_total_cost")
    the_overhead_expense.plan_id = params.fetch("query_plan_id")
    the_overhead_expense.user_id = params.fetch("query_user_id")

    if the_overhead_expense.valid?
      the_overhead_expense.save
      redirect_to("/production_plans/#{the_overhead_expense.plan_id}", { :notice => "Overhead expense updated successfully."} )
    else
      redirect_to("/overhead_expenses/#{the_overhead_expense.id}", { :alert => the_overhead_expense.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_overhead_expense = OverheadExpense.where({ :id => the_id }).at(0)

    the_overhead_expense.destroy

    redirect_to("/overhead_expenses", { :notice => "Overhead expense deleted successfully."} )
  end
end
