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

ActiveRecord::Schema[7.0].define(version: 2023_04_28_001918) do
  create_table "addresses", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "public_place", null: false
    t.string "zip_code", limit: 8, null: false
    t.string "reference"
    t.string "complement"
    t.string "number", limit: 15, null: false
    t.string "neighborhood", null: false
    t.bigint "city_id", null: false
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
    t.index ["city_id"], name: "index_addresses_on_city_id"
  end

  create_table "administrators", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_administrators_on_user_id"
  end

  create_table "chefs", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "address_id", null: false
    t.bigint "approver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_chefs_on_address_id"
    t.index ["approver_id"], name: "index_chefs_on_approver_id"
    t.index ["user_id"], name: "index_chefs_on_user_id"
  end

  create_table "cities", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "customers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "birthday", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "dishes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "chef_id", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.boolean "available", default: false, null: false
    t.boolean "active", default: false, null: false
    t.decimal "unit_price", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chef_id"], name: "index_dishes_on_chef_id"
  end

  create_table "states", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "acronym", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "telephones", charset: "utf8mb4", force: :cascade do |t|
    t.string "number", limit: 11, null: false
    t.string "contactable_type"
    t.bigint "contactable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contactable_type", "contactable_id"], name: "index_telephones_on_contactable"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "cpf", limit: 11, null: false
    t.string "email", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf", "email"], name: "index_users_on_cpf_and_email", unique: true
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "administrators", "users"
  add_foreign_key "chefs", "addresses"
  add_foreign_key "chefs", "administrators", column: "approver_id"
  add_foreign_key "chefs", "users"
  add_foreign_key "cities", "states"
  add_foreign_key "customers", "users"
  add_foreign_key "dishes", "chefs"
end
