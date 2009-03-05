require 'test_helper'
#set_session_for(record_object)
#set_cookie_for(record_object)
#set_http_auth_for(username, password)

class TasksControllerTest < ActionController::TestCase
  context "description" do
    setup do
      get :show, :id => 1
    end
    should_assign_to :task
    should_render_with_layout 'showpage'
  end
  
  context "create a new task" do
    setup do
      set_session_for(users(:ben))
      set_cookie_for(users(:ben))
      get :new
    end
    #should_assign_to :task
    
  
  end
  
end
