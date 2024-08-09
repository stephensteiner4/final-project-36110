# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_09_000153) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "greenhouse_utilizations", force: :cascade do |t|
    t.integer "time"
    t.float "total_benchspace"
    t.integer "plan_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string "description"
    t.integer "crop_time"
    t.integer "plan_id"
    t.float "material_cost"
    t.integer "retail_week"
    t.integer "container_size"
    t.float "soil_cost"
    t.float "unit_price"
    t.string "unit_margin"
    t.float "buffer"
    t.float "bench_space"
    t.float "unit_cost"
    t.float "sqft_cost"
    t.integer "user_id"
    t.float "sqft_margin"
    t.string "container_type"
    t.float "unit_container_cost"
    t.float "unit_tag_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "miscellaneous"
    t.float "shrink_opportunity_cost"
    t.float "total_qty"
  end

  create_table "overhead_expenses", force: :cascade do |t|
    t.string "category"
    t.decimal "total_cost"
    t.integer "plan_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "direct_cost"
  end

  create_table "production_plans", force: :cascade do |t|
    t.string "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.decimal "total_space"
    t.float "soil_cost"
    t.integer "prod_weeks"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
