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

ActiveRecord::Schema.define(version: 2022_04_13_185602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blacklists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_blacklists_on_jti", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

  create_table "consignments", force: :cascade do |t|
    t.string "status"
    t.string "bundle_seria"
    t.string "bundle_number"
    t.string "consignment_seria"
    t.string "consignment_number"
    t.string "truck_number"
    t.string "first_name"
    t.string "second_name"
    t.string "passport"
    t.string "contractor_name"
    t.integer "user_id"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "checked_date"
    t.integer "checked_user_id"
    t.string "placed_date"
    t.integer "placed_user_id"
    t.integer "warehouse_id"
    t.string "rechecked_date", default: "N/A"
    t.integer "rechecked_user_id"
    t.string "shipped_date", default: "N/A"
    t.integer "shipped_user_id"
    t.integer "company_id"
    t.boolean "reported", default: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "passport_number"
    t.string "passport_info"
    t.integer "contractor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods", force: :cascade do |t|
    t.string "name"
    t.string "quantity"
    t.string "status"
    t.string "bundle_seria"
    t.string "bundle_number"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "consignment_id"
    t.string "checked_date", default: "N/A"
    t.integer "checked_user_id"
    t.string "placed_date", default: "N/A"
    t.integer "placed_user_id"
    t.integer "warehouse_id"
    t.string "rechecked_date", default: "N/A"
    t.integer "rechecked_user_id"
    t.string "shipped_date", default: "N/A"
    t.integer "shipped_user_id"
    t.integer "company_id"
  end

  create_table "product_batches", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "serial"
    t.integer "number"
  end

  create_table "report_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "reported_goods", force: :cascade do |t|
    t.string "name"
    t.string "reported_quantity"
    t.string "quantity"
    t.string "status"
    t.string "bundle_seria"
    t.string "bundle_number"
    t.string "date"
    t.integer "consignment_id"
    t.integer "report_id"
    t.integer "good_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "report_date"
    t.string "description"
    t.integer "report_type_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "consignment_id"
    t.integer "company_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.string "area"
    t.integer "warehouse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.string "reserved", default: "0"
  end

  create_table "transports", force: :cascade do |t|
    t.string "brand"
    t.string "car_number"
    t.integer "contractor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transport_type_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.string "code"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "birth_date"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.integer "user_role_id"
    t.integer "warehouse_id"
    t.boolean "active", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "area"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reserved", default: "0"
    t.boolean "active", default: true
  end

end
