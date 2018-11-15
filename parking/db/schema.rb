# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_01_093725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string "number"
    t.string "driver_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "region"
  end

  create_table "cash_box_moments", force: :cascade do |t|
    t.money "cash", scale: 2
    t.datetime "date"
    t.bigint "parking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_id"], name: "index_cash_box_moments_on_parking_id"
  end

  create_table "cash_box_operations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "history_entries", force: :cascade do |t|
    t.bigint "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.boolean "action"
    t.index ["car_id"], name: "index_history_entries_on_car_id"
  end

  create_table "history_of_cashboxes", force: :cascade do |t|
    t.bigint "history_reservation_id"
    t.bigint "user_id"
    t.datetime "date_payment"
    t.money "cash", scale: 2
    t.bigint "cash_box_operation_id"
    t.bigint "pay_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parking_id"
    t.index ["cash_box_operation_id"], name: "index_history_of_cashboxes_on_cash_box_operation_id"
    t.index ["history_reservation_id"], name: "index_history_of_cashboxes_on_history_reservation_id"
    t.index ["parking_id"], name: "index_history_of_cashboxes_on_parking_id"
    t.index ["pay_type_id"], name: "index_history_of_cashboxes_on_pay_type_id"
    t.index ["user_id"], name: "index_history_of_cashboxes_on_user_id"
  end

  create_table "history_reservations", force: :cascade do |t|
    t.bigint "rate_id"
    t.bigint "parking_place_id"
    t.bigint "car_id"
    t.datetime "date_in"
    t.datetime "date_out"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.index ["car_id"], name: "index_history_reservations_on_car_id"
    t.index ["parking_place_id"], name: "index_history_reservations_on_parking_place_id"
    t.index ["rate_id"], name: "index_history_reservations_on_rate_id"
  end

  create_table "operators", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parking_id"
    t.index ["parking_id"], name: "index_operators_on_parking_id"
    t.index ["user_id"], name: "index_operators_on_user_id"
  end

  create_table "owners", force: :cascade do |t|
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "second_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_owners_on_user_id"
  end

  create_table "parking_places", force: :cascade do |t|
    t.bigint "parking_id"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "busy"
    t.index ["parking_id"], name: "index_parking_places_on_parking_id"
  end

  create_table "parkings", force: :cascade do |t|
    t.bigint "owner_id"
    t.integer "number_of_places"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_parkings_on_owner_id"
  end

  create_table "pay_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rate_intervals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rates", force: :cascade do |t|
    t.string "name"
    t.money "price", scale: 2
    t.datetime "date_from"
    t.datetime "date_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parking_id"
    t.bigint "rate_interval_id"
    t.index ["parking_id"], name: "index_rates_on_parking_id"
    t.index ["rate_interval_id"], name: "index_rates_on_rate_interval_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "login"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "cash_box_moments", "parkings"
  add_foreign_key "history_entries", "cars"
  add_foreign_key "history_of_cashboxes", "cash_box_operations"
  add_foreign_key "history_of_cashboxes", "history_reservations"
  add_foreign_key "history_of_cashboxes", "parkings"
  add_foreign_key "history_of_cashboxes", "pay_types"
  add_foreign_key "history_of_cashboxes", "users"
  add_foreign_key "history_reservations", "cars"
  add_foreign_key "history_reservations", "parking_places"
  add_foreign_key "history_reservations", "rates"
  add_foreign_key "operators", "parkings"
  add_foreign_key "operators", "users"
  add_foreign_key "owners", "users"
  add_foreign_key "parking_places", "parkings"
  add_foreign_key "parkings", "owners"
  add_foreign_key "rates", "parkings"
  add_foreign_key "rates", "rate_intervals"
  add_foreign_key "users", "roles"
end
