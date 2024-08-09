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

    plan.soil_cost = rand(250..300)

    plan.prod_weeks = [20,32,52].sample

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

  ### Materials Sample Data
  ProductionPlan.all.each do | prodplan |
    rand(50..500).times do | j | #
      matl = Material.new

      matl.description = ["Petunia", "Begonia", "Scaevola", "Canna", "Impatiens", "Nepeta", "Lavender", "Sunflower", "Lilly", "Tulip", "Daisy", "Salvia", "Lysimachia", "Peony", "Sedum", "Coreopsis", "Monstera", "Fern", "Snapdragon"].sample

      matl.crop_time = rand(6..12)

      matl.material_cost = rand(20..100) / 100.0

      matl.container_type = "Pot" #["Basket", "Tray", "Pot"]

      if matl.container_type == "Pot"
        diam = rand(4..10)

        matl.container_size = diam

        matl.soil_cost = (((3.14 * ((diam/2)**2) * diam) / 46656.0) * prodplan.soil_cost).round(2)
        
        matl.unit_price = ((diam ** 2) / 3.5).round(2)
      end

      matl.total_qty = rand(100..10000)

      matl.bench_space = ((diam**2/144.0) * matl.total_qty).round(2)

      matl.unit_tag_cost = rand(1..4) / 200.0

      matl.unit_container_cost = rand(1..4) / 10.0

      matl.miscellaneous = rand(1..10) / 100.0

      matl.buffer = rand(1..20)

      matl.shrink_opportunity_cost = ((matl.buffer/100.0) * matl.unit_price).round(2)

      matl.unit_cost = matl.shrink_opportunity_cost + matl.unit_container_cost + matl.unit_tag_cost + matl.material_cost + matl.soil_cost

      matl.total_cost = matl.unit_cost * matl.total_qty
      matl.total_revenue = matl.unit_price * matl.total_qty

      matl.sqft_cost = (matl.unit_cost * matl.total_qty) / matl.bench_space

      matl.plan_id = prodplan.id

      matl.user_id = prodplan.user_id

      matl.save
    end
  end

end
