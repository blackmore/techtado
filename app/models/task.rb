class Task < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  named_scope :to_do, :conditions => {:status => 1}
  named_scope :outstanding, :conditions => ['status >= ?', 0 ]
  named_scope :marked_as_wip, :conditions => {:status => 0}
  named_scope :frozen, :conditions => {:status => -2}
  named_scope :finished, :conditions => {:status => -1}
  named_scope :recently_completed, :conditions => {:status => -1}, :order => 'finished_at DESC', :limit => '6'
  
  def self.search(search)
    if search
      find(:all, :conditions => ['description LIKE ?', "%#{search}%"])
    else
      outstanding
    end
  end
  
  def self.per_page
    15
  end
  
  def status_to_str
    case status
    when 1 : "To Do"
    when 0 : "Being worked on"
    when -1 : "Finished"
    end
  end
  
  def deliver_status_changed!
    Postoffice.deliver_status_changed(self)
  end
  
  def deliver_notify!
    @notify_users = User.notify(self.urgent)
    if @notify_users.length > 0
      Postoffice.deliver_notify(@notify_users, self)
    end
  end
  
  def deliver_comment_notify!
    user_id_list = [ self.user_id, self.assigned_to, self.finished_by ].uniq.compact
    if user_id_list.include?(self.comments.last.user_id)
      user_id_list = user_id_list - [self.comments.last.user_id]
      exit if user_id_list == []
    end
    
    unless user_id_list.include?(self.comments.last.user_id)
      emails = user_id_list.collect{ |i| User.find(i).email }
      Postoffice.deliver_comment_notify(self, emails)
    end
  end
  
  
  def freezed?
    status == -2
  end
  
end
