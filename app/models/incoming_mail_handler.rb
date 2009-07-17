class IncomingMailHandler < ActionMailer::Base

  def receive(recived_email)
    sender = recived_email.from[0]
    puts "- have email #{sender}-"
    # Check to see if the sender of the mail is a registered user

    if User.exists?(:email => sender) 
     
     # gets user
     user = User.find_by_email(sender)
     
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
   end
end
 
 private
 
 def create_body(mail, email)
   "#{email.subject}\n#{mail.body}"
  end

end