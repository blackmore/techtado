class IncomingMailHandler < ActionMailer::Base 
  def receive(email)
    sender = email.from[0]
    
    # Check to see if the sender of the mail is a registered user
    if User.exists?(:email => sender)
      
      user = User.find_by_email(sender)
      
      # Cleanes the body text
      mail = MMS2R::Media.new(email)
      
      # Builds a new task
      # Have to build out the description form a bit more.
      @task = Task.new( :user_id => user.id,
                        :status => 1,
                        :assigned_to => nil,
                        :resubmit => 0,
                        :description => mail.body,
                        :send_email => true,
                        :urgent => false
                         )
      
      # if the email has attachments the build up the task object with the files
      if email.has_attachments?
        email.attachments.each do |file|
          @task.assets.build(:file => file)
          puts "- file -"
        end
      end
      
      # Save the submitted task.
      if @task.save
        puts "- saved task -"
      else
        # send notification of error
        puts "- something went wrong"
      end
    end
  end 

end