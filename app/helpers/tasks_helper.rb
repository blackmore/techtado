module TasksHelper
  def description_heading(description)
    string = find_description_head(description)
    if description > string
      string + ' ...'
    else
      string
    end
	end
	
	def find_description_head(text, count = 34)
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
	
	def description_heading_sidebar(description)
    string = find_description_head_sidebar(description)
    if description > string
      string + ' ...'
    else
      string
    end
	end
	
	def find_description_head_sidebar(text, count = 27)
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

	def get_status(task)
	  s = task.status
	  case s
  	  when -1 : 'tsk_statusFinished'
  	  when 0 :  'tsk_statusWIP'
  	  when -2 :  'tsk_statusFreeze'
      else  'tsk_statusTodo'
	  end
	end
	
	def get_user_name(n)
	  user = User.find(n)
	  user.first_name
	end
	
  def resubmitted(task)
    value = task.resubmit
    if value > 0
      case value
      when 1: " - <span class='reSubmit_1'>#{t('task.details.resubmitted')} #{task.resubmit}</span>"
      when 2: " - <span class='reSubmit_2'>#{t('task.details.resubmitted')} #{task.resubmit}</span>"
      when 3: " - <span class='reSubmit_3'>#{t('task.details.resubmitted')} #{task.resubmit}</span>"
      else    " - <span class='reSubmit'>#{t('task.details.resubmitted')} #{task.resubmit}</span>" 
      end
    end
  end
  
  def user_full_name(n)
    if n
      user = User.find(n)
      "#{user.first_name} #{user.last_name.first}."
    else
      "-"
    end
  end
  
  def show_date(date)
    if date
      date.strftime("%d.%m.%y")
    else
      "-"
    end
  end
  
  def format_text(text)
    text.gsub!(/\n/, "<br />")
    text
  end

  def who_status_time(task)
    status = task.status
    user_id, date = case status
                      when  0:  [task.assigned_to, task.assigned_at] 
                      when -1:  [task.finished_by, task.finished_at]
                      else      task.resubmit > 0 ? [task.resubmitted_by, task.resubmitted_at] : [task.user_id, task.created_at]
                    end
    user = User.find(user_id)
    
    case status
    when 0: "#{user.first_name.capitalize}'s #{t('task.assigned_to')} #{time_ago_in_words(date)}." 
    when -1: "#{user.first_name.capitalize} #{t('task.finished')} #{time_ago_in_words(date)} #{t('task.ago')}"
    else    "#{user.first_name.capitalize} #{task.resubmit > 0 ? t('task.resubmitted') : t('task.submitted') } #{time_ago_in_words(date)} #{t('task.ago')}"
    end
  end
  
  def show_description(task)
    description = task.description
    headding = find_description_head(description)
    if description > headding
      @headding = headding
      body = description.sub!(headding, "")
       if body =~ /^\n/
         @description = body.sub!(/\n/, "")
        end
        body.gsub!(/\n/, "<br />")
        @description = body
    else
      @headding = headding
      @description = ""
    end
  end
  
  def change_status_link(task)
    status = task.status
    if current_user && !task.freezed?
      user_id = current_user.id
      
      if status == 0 && task.assigned_to == user_id
        link = link_to_remote t('task.status_link.bounce'), :url => update_show_page_path(@task, :status => 'bounce' ), :html => {:class => "change_status"}
      else
        link = link_to_remote t('task.status_link.snatch'), :url => update_show_page_path(@task, :status => 'assign_to_user'), :html => {:class => "change_status"}
      end
      
      case status
      when 0: link
      when -1: link_to_remote t('task.status_link.resubmit'), :url => update_show_page_path(@task, :status => 'resubmit'), :html => {:class => "change_status"}
      else     link_to_remote t('task.status_link.Ill_do_this'), :url => update_show_page_path(@task, :status => 'assign_to_user'), :html => {:class => "change_status"}
      end
    end
  end
  
  
  def comments(task)
    number = task.comments.length
    if number > 0
      link_to "#{number}" + (number > 1 ? t('task.comment.plural') : t('task.comment.singular')), task, :class => "tsk_comments"
    else
      if current_user
        link_to('add comment', task, :class => "tsk_comments" )
      else
        'No comments'
      end
    end
  end
  
  def belongs_to_user(task)
    if current_user.id == task.assigned_to
      'belongs_to_user'
    else
      ''
    end
  end


  #----- MAYBE_USE_LATER -----#
    #  def urgent?(task)
    #    if task.urgent
    #      '<div class="urgent"></div>'
    #    else
    #      '<div class="not_urgent"></div>'
    #    end
    #  end

 def urgent?(task)
   if task.urgent
     "urgent#{rand(2)}"
   else
     ''
   end
 end
 
 def has_attachment(task)
  unless task.assets.empty?
    image_tag 'index_paperclip.png', :id => "paperclip"
  end
 end
 
 # TODO remove all this and do the same thing with CSS. a[href$=".png"] {ect.. }
 
 def filetype_class(asset)
   sufix = /\.\w\w\w\w?|\.\w\w\w?|\.\w\w?/.match(asset.file.original_filename)
   case sufix[0] ||= ".txt"
            when /.txt|.rb|.srt|.SRT/ : "txt"
            when /.zip|.ZIP/ : "zip"
            when /.doc|.rtf/ : "doc"
            when /.ezt|.890|.stl|.pac/ : "sub"
            when /.pdf|.PDF/ : "pdf"
            when /.mov|.avi|.wmv/ : "mov"
            when /.png|.jpg|.bmp|.jpeg|.tif/ : "img"
            else "txt"
            end
 end
  

 def crop_name(string, count = 25)
   if string.length > count
     length_of_string = string.length
     string_start = string[0,18]
     string_end = string[(length_of_string-8)..length_of_string]
     return "#{string_start}...#{string_end}"
   else
     string
   end
 end

  

  	
end
