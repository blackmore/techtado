class AddVideoNotification < ActiveRecord::Migration
  def self.up
    add_column :users, :video_archive_notify, :boolean, :default => false
    
    User.find(:all) do |user|
      user.update_attributes(:video_archive_notify => false )
    end
  end

  def self.down
    remove_column :users, :video_archive_notify
  end
end
