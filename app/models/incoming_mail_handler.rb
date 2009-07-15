class IncomingMailHandler < ActionMailer::Base 
  def receive(email)
    sender = email.from[0]
    puts "- have email -"
 #   # Check to see if the sender of the mail is a registered user
 #   if User.exists?(:email => sender)
 #     
 #     user = User.find_by_email(sender)
 #     
 #     # Cleanes the body text
 #     mail = MMS2R::Media.new(email)
 #     
 #     # Builds a new task
 #     # Have to build out the description form a bit more.
 #     @task = Task.new( :user_id => user.id,
 #                       :status => 1,
 #                       :assigned_to => nil,
 #                       :resubmit => 0,
 #                       :description => create_body(mail, email),
 #                       :send_email => true,
 #                       :urgent => false
 #                        )
 #     
 #     # if the email has attachments the build up the task object with the files
 #     if email.has_attachments?
 #       email.attachments.each do |file|
 #         @task.assets.build(:file => file)
 #         puts "- file -"
 #       end
 #     end
 #     
 #     # Save the submitted task.
 #     if @task.save!
 #       #Postoffice.deliver_task_added(user)
 #       puts "- saved task -"
 #     else
 #       # send notification of error
 #       puts "- something went wrong"
 #     end
 #   end
 # end
 # 
 # private
 # 
 # def create_body(mail, email)
 #   "#{email.subject}\n#{mail.body}"
 # end

end