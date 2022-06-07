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

ActiveRecord::Schema.define(version: 2022_05_26_103049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.integer "company_id"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

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
    t.boolean "reported", default: false
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
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
