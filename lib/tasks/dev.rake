desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  puts "Sample data task running"
  if Rails.env.development?
    User.destroy_all
    ProductionPlan.destroy_all
  end

  if Rails.env.production?
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  usernames = ["alice", "bob", "carol", "dave", "eve"]

  usernames.each do |username|
    user = User.new
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save
  end

  User.all.each do |user_plan|
    plan = ProductionPlan.new
    plan.name = ["Spring 2025", "Fall 2024", "Spring 2026", "Fall 2026"].sample

    plan.description = Faker::Movies::Lebowski.quote

    plan.user_id = user_plan.id

    plan.save

  end

  ProductionPlan.all.each do | prodplan |
    ["Fuel", "Management Salary", "Equipment"].each do | exp |
      expense = OverheadExpense.new

      expense.category = exp

      expense.total_cost = rand(10000..200000)

      expense.plan_id = prodplan.id

      expense.user_id = prodplan.user_id

      expense.save

    end
  end
end
