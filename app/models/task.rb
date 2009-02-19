class Task < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  named_scope :to_do, :conditions => {:status => 1}
  named_scope :outstanding, :conditions => ['status >= ?', 0 ]
  named_scope :marked_as_wip, :conditions => {:status => 0}
  named_scope :frozen, :conditions => {:status => -2}
  named_scope :finished, :conditions => {:status => -1}
  named_scope :recently_completed, :conditions => {:status => -1}, :order => "finished_at DESC", :limit => '6'
  
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
  
  def freezed?
    status == -2
  end
  
end
