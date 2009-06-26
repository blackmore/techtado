class ChangeDefaultSettings < ActiveRecord::Migration
  def self.up
    remove_column :users, :notify_on
    remove_column :users, :new_video_notify
    add_column :users, :notify_on, :string,               :default => "create"
    add_column :users, :new_video_notify, :string,        :default => "all"
  end

  def self.down
    remove_column :users, :new_video_notify
    remove_column :users, :notify_on
    add_column :users, :new_video_notify, :string
    add_column :users, :notify_on, :string,               :default => "None"
  end
end
