require 'test_helper'
#require File.dirname(__FILE__) + '/../test_helper'

class TasksControllerTest < ActionController::TestCase
  context "on GET to :show for first record" do
    setup do
      @task = Task.create(:description => "tell")
     #get :show, :id => 1
    end

#    should_assign_to :task
#    should_respond_with :success
#    should_render_template :show
#    should_not_set_the_flash

    should "do something else really cool" do
      #assert_equal 1, assigns(:task).id
    end
  end
  
  
#  context "A Task instance" do
#      setup do
#        @task = Factory(:task)
#      end
#      
#      should "return its full name" do
#          assert_equal 'Small test', @task.description
#          assert_equal  1, @task.status
#        end
#      end
end
