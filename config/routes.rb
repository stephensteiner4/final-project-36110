Rails.application.routes.draw do
  
  devise_for :users

  root "production_plans#index"
  
  # Routes for the Material resource:

  # CREATE
  post("/insert_material", { :controller => "materials", :action => "create" })

  # COPY
  post("/copy_material/:path_id", { :controller => "materials", :action => "copy" })
          
  # READ
  
  get("/materials/:path_id", { :controller => "materials", :action => "show" })
  
  # UPDATE
  
  post("/modify_material/:path_id", { :controller => "materials", :action => "update" })
  
  # DELETE
  get("/delete_material/:path_id", { :controller => "materials", :action => "destroy" })

  #------------------------------

  # Routes for the Overhead expense resource:

  # CREATE
  post("/insert_overhead_expense", { :controller => "overhead_expenses", :action => "create" })
          
  # READ
  
  get("/overhead_expenses/:path_id", { :controller => "overhead_expenses", :action => "show" })
  
  # UPDATE
  
  post("/modify_overhead_expense/:path_id", { :controller => "overhead_expenses", :action => "update" })
  
  # DELETE
  get("/delete_overhead_expense/:path_id", { :controller => "overhead_expenses", :action => "destroy" })

  #------------------------------

  # Routes for the Production plan resource:

  # CREATE
  post("/insert_production_plan", { :controller => "production_plans", :action => "create" })

  # CREATE
  post("/copy_production_plan/:path_id", { :controller => "production_plans", :action => "copy" })
          
  # READ
  get("/production_plans", { :controller => "production_plans", :action => "index" })
  
  get("/production_plans/:path_id", { :controller => "production_plans", :action => "show" })
  
  # UPDATE
  
  post("/modify_production_plan/:path_id", { :controller => "production_plans", :action => "update" })
  
  # DELETE
  get("/delete_production_plan/:path_id", { :controller => "production_plans", :action => "destroy" })

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
