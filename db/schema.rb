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

ActiveRecord::Schema.define(version: 20150127220947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "medical_causes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_codes", force: true do |t|
    t.string   "code_value"
    t.string   "code_system"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_condition_medical_causes", force: true do |t|
    t.integer  "medical_condition_id"
    t.integer  "medical_cause_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_condition_medical_codes", force: true do |t|
    t.integer  "medical_condition_id"
    t.integer  "medical_code_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_conditions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_therapies", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "possible_treatments", force: true do |t|
    t.integer  "medical_condition_id"
    t.integer  "medical_therapy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "primary_preventions", force: true do |t|
    t.integer  "medical_condition_id"
    t.integer  "medical_therapy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end