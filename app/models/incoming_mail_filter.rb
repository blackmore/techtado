class IncomingMailFilter < ActionMailer::Base


    def receive(message)
      begin
        
        

#     mail = TMail::Mail.parse(message)
#     #mms = MMS2R::Media.new(mail)
#     
#     sender = "nigel@blackmore.de"
      puts "- have email -"
      puts "#{RAILS_ENV}"
#     # Check to see if the sender of the mail is a registered user
           if ActiveRecord::Base::User.exists?(:email => "nigel@blackmore.de")
       puts "- user exists -"


      # gets user
      user = User.find_by_email("nigel@blackmore.de")
      puts "- user ID = #{user.id} -"
     end
#      # Creates a mms2r object to help clean up unwanted data
#      mms = MMS2R::Media.new(message)
#
#      # Builds a new task
#      task = Task.new( :user_id => user.id,
#                        :status => 1,
#                        :assigned_to => nil,
#                        :resubmit => 0,
#                        :description => create_body(mms, mail),
#                        :send_email => true,
#                        :urgent => false
#                         )
#
#      # if the email has attachments the build up the task object with the files
#      if recived_email.has_attachments?
#        recived_email.attachments.each do |file|
#          task.assets.build(:file => file)
#          puts "- file -"
#        end
#      end
#
#      # Save the submitted task.
#      if task.save
#        Postoffice.deliver_task_added(user)
#        puts "- saved task -"
#      else
#        # send notification of error
#        puts "- something went wrong"
#      end
#    else
#      put "user not found"
#    end
  rescue  
      puts 'I am rescued.'
end
 end

  private

  def create_body(mail, email)
    "#{email.subject}\n#{mail.body}"
   end
end