# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140502010515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: true do |t|
    t.string   "appointment_id"
    t.date     "date"
    t.integer  "insurance_cost"
    t.string   "address"
    t.text     "notes"
    t.boolean  "on_campus"
    t.date     "request_date"
    t.string   "coupon_code"
    t.boolean  "price_match"
    t.string   "referrer"
    t.boolean  "pre_arrival"
    t.string   "pre_arrival_address"
    t.integer  "contract_id"
    t.boolean  "at_counter"
    t.date     "term_ends"
    t.integer  "term_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "appointment_type"
    t.boolean  "is_cancelled"
    t.integer  "timeslot_number"
    t.string   "timeslot_text"
    t.string   "referral_source"
    t.integer  "tip"
    t.integer  "percent_discount"
    t.integer  "fuel_surcharge"
    t.integer  "packaging_hours"
  end

  create_table "contracts", force: true do |t|
    t.integer  "user_id"
    t.string   "contract_id"
    t.string   "contract_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.boolean  "is_cancelled"
    t.integer  "half_terms"
  end

  create_table "items", force: true do |t|
    t.integer  "contract_id"
    t.string   "item_type"
    t.string   "description"
    t.text     "notes"
    t.decimal  "weight"
    t.string   "pallet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "box_id"
    t.boolean  "is_deleted"
    t.integer  "value"
    t.boolean  "should_insure"
    t.integer  "custom_price"
  end

  create_table "supplies", force: true do |t|
    t.integer  "appointment_id"
    t.string   "description"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supply_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "fname"
    t.string   "lname"
    t.string   "password_digest"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state",            limit: 2
    t.string   "remember_token"
    t.string   "zip"
    t.string   "phone"
    t.string   "country"
    t.boolean  "is_rep"
    t.boolean  "is_admin"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "net_id"
    t.string   "gender",           limit: 1
    t.string   "school"
    t.string   "major"
    t.string   "grad_year",        limit: 4
    t.date     "dob"
    t.boolean  "is_international"
    t.boolean  "should_spam"
  end

end
