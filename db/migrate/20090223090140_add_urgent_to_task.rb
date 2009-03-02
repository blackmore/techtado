class AddUrgentToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :urgent, :boolean
    
    Task.find(:all) do |task|
      task.update_attributes(:urgent => nil)
    end
  end

  def self.down
    remove_column :tasks, :urgent
  end
end
