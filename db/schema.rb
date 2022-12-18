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

ActiveRecord::Schema.define(version: 2022_12_16_111759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "banner_managements", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 100
    t.integer "parent_id"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
  end

  create_table "configurations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "conf_key", limit: 45
    t.string "conf_value", limit: 100
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
  end

  create_table "coupons", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code", limit: 45
    t.decimal "percent_off"
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.integer "no_of_uses"
  end

  create_table "coupons_useds", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "coupon_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coupon_id"], name: "index_coupons_useds_on_coupon_id"
    t.index ["user_id"], name: "index_coupons_useds_on_user_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "quantity"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.bigint "user_order_id", null: false
    t.index ["product_id"], name: "index_order_details_on_product_id"
    t.index ["user_order_id"], name: "index_order_details_on_user_order_id"
  end

  create_table "product_attribute_assocs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_product_attribute_assocs_on_product_id"
  end

  create_table "product_attribute_values", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "attribute_value", limit: 45
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.bigint "product_attributes_id", null: false
    t.index ["product_attributes_id"], name: "index_product_attribute_values_on_product_attributes_id"
  end

  create_table "product_attributes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 45
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
  end

  create_table "product_categories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "images_name", limit: 100
    t.integer "status", default: 0
    t.integer "created_by"
    t.integer "modify_by"
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 100
    t.string "sku", limit: 45
    t.string "short_description", limit: 100
    t.string "long_description", limit: 100
    t.decimal "price"
    t.decimal "special_price"
    t.date "special_price_from"
    t.date "special_price_to"
    t.integer "status", default: 0
    t.integer "created_by"
    t.date "created_date"
    t.integer "modify_by"
    t.date "modify_date"
    t.integer "quantity"
  end

  create_table "subcategories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category_id"
    t.string "subcategory_name"
  end

  create_table "user_addresses", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "Address", limit: 200
    t.integer "pin_code"
    t.string "mobile_no"
    t.string "Country"
    t.string "State"
    t.string "Alternate_mobile_no"
  end

  create_table "user_orders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "awb_no", limit: 100
    t.string "transaction_id", limit: 100
  end

  create_table "user_wish_lists", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_user_wish_lists_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "superadmin_role"
    t.boolean "supervisor_role"
    t.boolean "user_role"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "coupons_useds", "coupons"
  add_foreign_key "coupons_useds", "users"
  add_foreign_key "order_details", "products"
  add_foreign_key "order_details", "user_orders"
  add_foreign_key "product_attribute_assocs", "products"
  add_foreign_key "product_attribute_values", "product_attributes", column: "product_attributes_id"
  add_foreign_key "product_categories", "categories"
  add_foreign_key "product_categories", "products"
  add_foreign_key "product_images", "products"
  add_foreign_key "user_wish_lists", "products"
end
