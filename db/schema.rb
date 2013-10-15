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

ActiveRecord::Schema.define(:version => 20131015193454) do

  create_table "apis", :force => true do |t|
    t.integer  "user_id"
    t.integer  "entity"
    t.string   "key_id"
    t.string   "v_code"
    t.integer  "accessmask"
    t.integer  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "apis", ["user_id", "active"], :name => "index_apis_on_user_id_and_valid"

  create_table "cache_times", :force => true do |t|
    t.integer  "user_id"
    t.integer  "api_id"
    t.datetime "cached_time"
    t.integer  "call_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "cache_times", ["user_id", "api_id"], :name => "index_cache_times_on_user_id_and_api_id"

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.integer  "char_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "corporations", :force => true do |t|
    t.string   "name"
    t.integer  "corp_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "market_item_summaries", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "average_purchase_price"
    t.decimal  "average_sale_price"
    t.decimal  "average_percent_markup"
    t.integer  "total_vol_entered"
    t.integer  "total_vol_remaining"
    t.integer  "type_id"
    t.integer  "station_id"
    t.integer  "char_id"
    t.integer  "entity"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.boolean  "bid"
  end

  create_table "market_orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "api_id"
    t.integer  "market_item_summary_id"
    t.integer  "order_id"
    t.integer  "station_id"
    t.integer  "vol_entered"
    t.integer  "vol_remaining"
    t.integer  "min_volume"
    t.integer  "order_state"
    t.integer  "type_id"
    t.integer  "reach"
    t.integer  "account_key"
    t.integer  "duration"
    t.decimal  "escrow"
    t.decimal  "price"
    t.boolean  "bid"
    t.datetime "issued"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "char_id"
  end

  add_index "market_orders", ["user_id", "api_id"], :name => "index_market_orders_on_user_id_and_api_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
