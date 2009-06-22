class Video < ActiveRecord::Base
  before_validation :round_up_length
  belongs_to :customer
  validates_presence_of :title
  validates_presence_of :length
  validates_presence_of :source_media
  validates_presence_of :customer_id
  validates_format_of :title, :with => /^.+\.mpg|avi|wmv|MPG|AIV|WMV$/, :on => :create, :message => "is invalid"
  validates_format_of :length, :with => /^\d+(.\d+|'\d+)?/, :on => :create, :message => "is invalid"
  
  SOURCES = ["film", "disc", "tape", "digital"]
  
  def customer_name
    customer.name if customer
  end
  
  def customer_name=(name)
    name.chomp!(" ")
    self.customer = Customer.find_or_create_by_name(name) unless name.blank?
  end
  
  
  def round_up_length
    if self.length =~ /\d+'\d+/
      self.length.gsub!("'", ".")
    end
    self.length = self.length.to_f.ceil
  end
  
  def details=(video_attributes)
  end
  
  def deliver_notification!(videos)
    # collect all the users that would like to be notified
    notify_users = user_notify_custom_list(self.customer.name) + User.any_new_video

    # put the email addresses into an array
    notify_user_emails = notify_users.collect{ |i| i.email }
    
    if !notify_users.empty?
      Postoffice.deliver_notification(self, notify_user_emails, videos)
    end
  end
  
  def user_notify_custom_list(customer)
    users = User.custom_new_video
    if !users.empty?
      users.each do |user|
       customers = user.new_video_notify_filter.split(', ')
       if !customers.include?(customer)
         users.delete(user)
       end
      end
      users
    else
      []
    end
  end
end
