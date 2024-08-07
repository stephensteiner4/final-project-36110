desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  puts "Sample data task running"
  if Rails.env.development?
    User.destroy_all
    ProductionPlan.destroy_all
    OverheadExpense.destroy_all
  end

  if Rails.env.production?
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

#### User sample data
  usernames = ["alice", "bob", "carol", "dave", "eve"]

  usernames.each do |username|
    user = User.new
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save
  end

#### Production plan sample data
  User.all.each do |user_plan|
    plan = ProductionPlan.new
    plan.name = ["Spring 2025", "Fall 2024", "Spring 2026", "Fall 2026"].sample

    plan.description = Faker::Movies::Lebowski.quote

    plan.user_id = user_plan.id

    plan.total_space = greenhouse_space = rand(10000..1000000)

    plan.save

  end

#### Greenhouse Utilization sample data
  ProductionPlan.all.each do | prodplan |

    12.times do | i |
      space = GreenhouseUtilization.new

      space.time = (i+1)

      space.plan_id = prodplan.id
      space.user_id = prodplan.user_id

      if prodplan.total_space >=50000
        if (i+1) <= 5
          space.total_benchspace = prodplan.total_space * ((i+1)/5.0)
        elsif ((i+1) > 5) & ((i+1) <= 8)
          space.total_benchspace = prodplan.total_space * (5.0/(i+1))
        elsif ((i+1) == 9)
          space.total_benchspace = 0
        elsif ((i+1) > 9) & ((i+1) < 12)
          space.total_benchspace = prodplan.total_space * (0.25)
        elsif ((i+1) == 12)
          space.total_benchspace = 0
        end
      elsif
        if ((i+1) <= 9) | ((i+1)!=1)
          space.total_benchspace = prodplan.total_space
        elsif ((i+1) > 10) | ((i+1)==1)
          space.total_benchspace = 0
        end
      end

      space.save

    end
  end

#### Fixed expenses sample data
  ProductionPlan.all.each do | prodplan |
    ["Fuel", "Management Salary", "Equipment", "Insurance", "Taxes", "Office Utilities", "Depreciation"].each do | exp |
      expense = OverheadExpense.new

      expense.category = exp

      expense.total_cost = rand(10000..200000)

      expense.plan_id = prodplan.id

      expense.user_id = prodplan.user_id

      expense.save

    end
  end
end
