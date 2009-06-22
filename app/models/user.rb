class User < ActiveRecord::Base
  
  named_scope :any_new_video, :conditions => {:new_video_notify => 'all'}
  named_scope :custom_new_video, :conditions => {:new_video_notify => 'custom'}
    
    def before_save
      if self.task_notify == false
        self.notify_on = "None"
      end
    end
    
  #----- Authlogic -----#
    acts_as_authentic
    validates_presence_of :first_name, :last_name
    
    def deliver_password_reset_instructions!
      reset_perishable_token!
      Postoffice.deliver_password_reset_instructions(self)
    end
    
  #----- * -----#
  
  def full_name
    [first_name, last_name].join(' ')
  end
  
    #----- LANGUAGES -----#
      LANG = [  ]
    #----- * -----#
    
    #----- NOTIFY -----#
    def self.notify(urgent)
      if urgent
        users_urgent = find_all_by_notify_on("urgent").collect{ |user| user.email}
        users_create = find_all_by_notify_on("create").collect{ |user| user.email}
        users = users_urgent + users_create
        users.uniq
      else
        users = find_all_by_notify_on("create").collect{ |user| user.email}
      end
    end
    #----- * -----#
    
    #------ Video Archive -------#
    def filtered_customers
      if self.new_video_notify_filter != nil
        customers = self.new_video_notify_filter.split(', ')
      else
        []
      end
    end
    
    

end
