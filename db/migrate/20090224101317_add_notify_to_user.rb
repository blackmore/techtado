class AddNotifyToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :notify_on, :string, :default => "None"
    add_column :users, :notify_method, :string, :default => "email"
    add_column :users, :jabber_address, :string, :default => "", :null => false
    
    User.find(:all) do |user|
      user.update_attributes(:notify_on => 'None', :notify_method => "email", :jabber_address => "" )
    end
  end

  def self.down
    remove_column :users, :jabber_address
    remove_column :users, :notify_method
    remove_column :users, :notify_on
  end
end
