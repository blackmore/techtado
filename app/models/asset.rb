class Asset < ActiveRecord::Base
  belongs_to :task
  has_attached_file :file
  
end