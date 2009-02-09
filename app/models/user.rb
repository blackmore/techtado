class User < ActiveRecord::Base
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
end
