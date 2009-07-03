module VideosHelper

  def pagination_links_remote(paginator)
    page_options = {:window_size => 1}
    pagination_links_each(paginator, page_options) do |n|
      options = {
        :url => {:action => 'list', :params => params.merge({:page => n})},
        :update => 'table',
        :before => "Element.show('spinner')",
        :success => "Element.hide('spinner')"
      }
      html_options = {:href => url_for(:action => 'list', :params => params.merge({:page => n}))}
      link_to_remote(n.to_s, options, html_options)
    end
  end
  
  def sort_td_class_helper(param)
    result = 'class="sortup"' if params[:sort] == param
    result = 'class="sortdown"' if params[:sort] == param + "_reverse"
    return result
  end
  
  def sort_link_helper(text, param)
    key = param
    key += "_reverse" if params[:sort] == param
    options = {
        :url => {:action => 'list', :params => params.merge({:sort => key, :page => nil})},
        :update => 'table',
        :before => "Element.show('spinner')",
        :success => "Element.hide('spinner')"
    }
    html_options = {
      :title => "Sort by this field",
      :href => url_for(:action => 'list', :params => params.merge({:sort => key, :page => nil}))
    }
    link_to_remote(text, options, html_options)
  end
  
  def crop_title(title, count = 50)
    if title.length > count
      length_of_string = title.length
      title_start = title[0,37]
      title_end = title[(length_of_string-8)..length_of_string]
      return "#{title_start} ... #{title_end}"
    else
      title
    end
  end
  
  def crop_customer(name, count = 30)
    if name.length > count
      length_of_string = name.length
      name_start = name[0,17]
      name_end = name[(length_of_string-8)..length_of_string]
      return "#{name_start} ... #{name_end}"
    else
      name
    end
  end
end
