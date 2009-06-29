# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090628123435) do

  create_table "comments", :force => true do |t|
    t.integer  "task_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.integer  "status"
    t.boolean  "send_email"
    t.integer  "assigned_to"
    t.datetime "finished_at"
    t.integer  "finished_by"
    t.datetime "assigned_at"
    t.integer  "resubmit"
    t.integer  "resubmitted_by"
    t.datetime "resubmitted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "urgent"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "perishable_token",        :default => "",      :null => false
    t.string   "email",                   :default => "",      :null => false
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notify_method",           :default => "email"
    t.string   "jabber_address",          :default => "",      :null => false
    t.boolean  "task_notify",             :default => false
    t.string   "new_video_notify_filter"
    t.boolean  "video_archive_notify",    :default => false
    t.string   "notify_on"
    t.string   "new_video_notify"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "source_media"
    t.string   "length"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
