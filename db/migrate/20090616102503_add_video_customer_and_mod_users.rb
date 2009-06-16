class AddVideoCustomerAndModUsers < ActiveRecord::Migration
  def self.up
    create_table :customers, :force => true do |t|
      t.string :name
      t.timestamps
    end
    create_table :videos, :force => true do |t|
      t.string :title
      t.string :source_media
      t.string :length
      t.integer :customer_id
      t.timestamps
    end
    add_column :users, :new_video_notify_filter, :string
    add_column :users, :new_video_notify, :string
  end

  def self.down
    remove_column :users, :new_video_notify
    remove_column :users, :new_video_notify_filter
    drop_table :videos
    drop_table :customers
  end
end
