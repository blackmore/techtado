class ModUserNotify < ActiveRecord::Migration
  def self.up
    remove_column :users, :notify_on
    remove_column :users, :new_video_notify
    add_column :users, :notify_on, :string,               :default => nil
    add_column :users, :new_video_notify, :string,        :default => nil
  end

  def self.down
    remove_column :users, :notify_on
    remove_column :users, :new_video_notify
    add_column :users, :notify_on, :string,               :default => "create"
    add_column :users, :new_video_notify, :string,        :default => "all"
  end
end
