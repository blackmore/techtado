class Comment < ActiveRecord::Base
  belongs_to :task
  
  def full_name
    User.find(user_id).full_name
  end
  
  def first_name
    User.find(user_id).first_name
  end
  
end
