class Customer < ActiveRecord::Base
  has_many :videos
  
  def customer_name
    self.name if customer
  end
  
  def customer_name=(name)
    self.name = Customer.find_or_create_by_name(name) unless name.blank?
  end
  
  def video_attributes=(video_attributes)
    video_attributes.each do |attributes|
      videos.build(attributes)
    end
  end
  
end
