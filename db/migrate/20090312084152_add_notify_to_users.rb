class AddNotifyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :task_notify, :boolean, :default => false
    
    User.find(:all) do |user|
      user.update_attributes(:task_notify => false )
    end
    
  end
  

  def self.down
    remove_column :users, :task_notify
  end
end
