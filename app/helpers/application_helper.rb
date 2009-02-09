# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #-----  adds a active class to the current page tab.  -----#
  def is_active?(page)
    if current_page?(:controller => page)
      "class='active'"
    else
      ""
    end
  end
  #----- * -----#
  
  #----- SHORT_TIME_AGO -----#
  def short_time_ago(time)
    string = time_ago_in_words(time)
    string.gsub!('about', '')
    string.gsub!('hours', 'hrs')
    string.gsub!('minutes', 'mins')
    string.gsub!('less than', 'under')
    string
  end
  #----- * -----#
end
