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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130411090054) do

  create_table "abilities", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "assets", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.string   "model"
    t.integer  "quantity"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "assets_characters", :force => true do |t|
    t.integer "asset_id"
    t.integer "character_id"
  end

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "fences"
    t.boolean  "gmaps"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.date     "contractendon"
    t.string   "email"
    t.integer  "contract_number"
    t.integer  "mobile_number"
  end

  create_table "companies", :force => true do |t|
    t.string   "company_name"
    t.string   "subdomain"
    t.string   "address"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "company_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "markers", :force => true do |t|
    t.integer  "character_id"
    t.string   "duration"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "message_templates", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "company_id"
    t.text     "signature"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notification_settings", :force => true do |t|
    t.boolean  "monthly_reminder"
    t.boolean  "bimonthly_reminder"
    t.boolean  "weekly_reminder"
    t.boolean  "oneday_reminder"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "plan_users", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "plan_id"
    t.integer  "user_id"
    t.boolean  "is_active"
  end

  create_table "plans", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.float    "price"
    t.string   "frequency"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "plan_type"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.string   "timezone"
    t.string   "mobile_number"
    t.string   "country"
    t.boolean  "is_active",              :default => false
    t.integer  "company_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
