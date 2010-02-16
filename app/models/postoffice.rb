class Postoffice < ActionMailer::Base
  # make note of the headers, content type, and time sent
  # these help prevent your email from being flagged as spam SPAM
  default_url_options[:host] = "10.1.1.211"
  
    def status_changed(task)
      @recipients   = task.user.email
      @from         = "Tech-tado <noreply@titelbild.de>"
      headers         "Reply-to" => "tech@titelbild.de"
      @subject      = "[#{status(task.status)}] #{subject_task(task.description)}"
      @sent_on      = Time.now
      @content_type = "text/html"
      
      body[:status] = task.status_to_str
      body[:task] = task 
      body[:link_to_show_task] = task_url(task)
    end
    
    def notify(emails, task)
      @recipients   = emails
      @from         = "Tech-tado <noreply@titelbild.de>"
      headers         "Reply-to" => "tech@titelbild.de"
      @subject      = "#{task.urgent ? '[URGENT!]' : '[New]'} #{subject_task(task.description)}"
      @sent_on      = Time.now
      @content_type = "text/html"
      body[:task] = task
      body[:link_to_show_task] = task_url(task)
    end
    
    def comment_notify(task, emails)
      @recipients   = emails
      @from         = "Tech-tado <noreply@titelbild.de>"
      headers         "Reply-to" => "tech@titelbild.de"
      @subject      = "#{task.comments.last.first_name} commented on \"#{subject_task(task.description)}\""
      @sent_on      = Time.now
      @content_type = "text/html"
      
      body[:latest_comment] = task.comments.last
      body[:task] = task 
      body[:link_to_show_task] = task_url(task)
    end
    
     def password_reset_instructions(user)
       subject       "Password Reset Instructions"
       from          "Tech-tado <noreply@titelbild.de>"
       recipients    user.email
       sent_on       Time.now
       body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
     end
     
     def notification(video, emails, videos)
       @recipients   = emails
       @from         = "Video_Archive <noreply@titelbild.de>"
       headers         "Reply-to" => "tech@titelbild.de"
       @subject      = "#{video.customer.name}, NEW! #{videos.length > 1 ? 'videos.' : 'video.'}" 
       @sent_on      = Time.now
       @content_type = "text/html"

       body[:videos] = videos
       body[:customer] = video.customer
       #body[:link_to_show_task] = "..."#task_url(task)
     end
     
     def task_added(user, task)
        @subject      = "[TASK ADDED] #{subject_task(task.description)}"
        @from         = "Tech-tado <noreply@titelbild.de>"
        headers         "Reply-to" => "tech@titelbild.de"
        @recipients   = user.email
        @sent_on      = Time.now
        @content_type = "text/html"
        
        body[:task] = task 
        body[:link_to_show_task] = task_url(task)
     end
     
     private
     
     def subject_task(text, count = 37)
     	  if text =~ /\n/
          split_on_return = text.split(/\n/)
          string = split_on_return[0]
        else
          string = text
        end

      	if string.length >= count 
      		shortened = string[0, count]
      		splitted = shortened.split(/\s/)
      		words = splitted.length
      		splitted[0, words-1].join(" ")
      	else 
      		string
      	end
     end
     
     def status(tasks_status)
      case tasks_status
        when 1 : "To Do"
        when 0 : "Working On"
        else "Finished"
      end
     end
end
