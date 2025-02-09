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

ActiveRecord::Schema.define(version: 2023_03_29_073027) do

  create_table "mask_pharmacies", force: :cascade do |t|
    t.float "price"
    t.integer "mask_id", null: false
    t.integer "pharmacy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mask_id"], name: "index_mask_pharmacies_on_mask_id"
    t.index ["pharmacy_id"], name: "index_mask_pharmacies_on_pharmacy_id"
  end

  create_table "masks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "opening_times", force: :cascade do |t|
    t.string "Mon"
    t.string "Tue"
    t.string "Wed"
    t.string "Thur"
    t.string "Fri"
    t.string "Sat"
    t.string "Sun"
    t.integer "pharmacy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pharmacy_id"], name: "index_opening_times_on_pharmacy_id"
  end

  create_table "pharmacies", force: :cascade do |t|
    t.string "name"
    t.float "cash_balance"
    t.string "opening_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "purchase_histories", force: :cascade do |t|
    t.string "pharmacy_name"
    t.string "mask_name"
    t.float "transaction_amount"
    t.string "transaction_date"
    t.integer "user_id", null: false
    t.integer "mask_id", null: false
    t.integer "pharmacy_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mask_id"], name: "index_purchase_histories_on_mask_id"
    t.index ["pharmacy_id"], name: "index_purchase_histories_on_pharmacy_id"
    t.index ["user_id"], name: "index_purchase_histories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.float "cash_balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "mask_pharmacies", "masks"
  add_foreign_key "mask_pharmacies", "pharmacies"
  add_foreign_key "opening_times", "pharmacies"
  add_foreign_key "purchase_histories", "masks"
  add_foreign_key "purchase_histories", "pharmacies"
  add_foreign_key "purchase_histories", "users"
end
