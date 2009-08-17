class IncomingMailHandler < ActionMailer::Base

  def receive(recived_email)
    sender = recived_email.from[0]
    puts "- have email #{sender}-"
    puts "#{RAILS_ENV}"
    # Check to see if the sender of the mail is a registered user
    begin
    if ActiveRecord::Base::User.exists?(:email => sender)
      puts "- user exists -"
     
     # gets user
     user = User.find_by_email(sender)
     puts "- user ID = #{user.id} -"
     
     # Creates a mms2r object to help clean up unwanted data
     mail = MMS2R::Media.new(recived_email)
     
     # Builds a new task
     task = Task.new( :user_id => user.id,
                       :status => 1,
                       :assigned_to => nil,
                       :resubmit => 0,
                       :description => create_body(mail, recived_email),
                       :send_email => true,
                       :urgent => false
                        )
     
     # if the email has attachments the build up the task object with the files
     if recived_email.has_attachments?
       recived_email.attachments.each do |file|
         task.assets.build(:file => file)
         puts "- file -"
       end
     end
     
     # Save the submitted task.
     if task.save
       Postoffice.deliver_task_added(user)
       puts "- saved task -"
     else
       # send notification of error
       puts "- something went wrong"
     end
   else
     put "user not found"
   end
     rescue  
         puts 'I am rescued.'
   end
end
 
 private
 
 def create_body(mail, email)
   "#{email.subject}\n#{mail.body}"
  end

end