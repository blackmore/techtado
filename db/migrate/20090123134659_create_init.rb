class CreateInit < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.integer "task_id"
      t.text     "body"
      t.integer  "user_id"
      t.timestamps
    end
    create_table :tasks, :force => true do |t|
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
      t.timestamps
    end
    create_table :users, :force => true do |t|
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
      t.string   "perishable_token",  :default => "", :null => false
      t.string   "email",             :default => "", :null => false
      t.string   "language"
      t.timestamps
    end
    
    add_index :users, :perishable_token
    add_index :users, :email
  end

  def self.down
    drop_table :users
    drop_table :table_name
    drop_table :table_name
  end
end


