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

ActiveRecord::Schema.define(:version => 20120410182206) do

  create_table "checkins", :force => true do |t|
    t.string   "facebook_checkin_id"
    t.string   "message"
    t.datetime "created_at"
    t.integer  "place_id"
  end

  add_index "checkins", ["facebook_checkin_id"], :name => "index_checkins_on_facebook_checkin_id"
  add_index "checkins", ["place_id"], :name => "index_checkins_on_place_id"

  create_table "checkins_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "checkin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkins_users", ["checkin_id"], :name => "index_checkins_users_on_checkin_id"
  add_index "checkins_users", ["user_id"], :name => "index_checkins_users_on_user_id"

  create_table "facebook_checkin_logs", :force => true do |t|
    t.string   "current"
    t.string   "next"
    t.string   "previous"
    t.string   "done"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             :default => 0
    t.string   "facebook_place_id"
    t.string   "facebook_id"
    t.datetime "time_created"
    t.string   "category"
    t.text     "description"
    t.string   "picture"
    t.integer  "likes"
    t.integer  "checkin_count"
  end

  add_index "places", ["facebook_id"], :name => "index_places_on_facebook_id"
  add_index "places", ["facebook_place_id"], :name => "index_places_on_facebook_place_id"

  create_table "places_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "token"
    t.string   "email",                                 :default => "",          :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",          :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "location"
    t.string   "privacy",                               :default => "protected"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["uid"], :name => "index_users_on_uid"

  create_table "walls", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wall_name"
    t.string   "slug"
  end

  add_index "walls", ["slug"], :name => "index_walls_on_slug", :unique => true

end
