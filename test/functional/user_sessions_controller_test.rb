#require 'test_helper'
require File.dirname(__FILE__) + '/../test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  context "A User instance" do
      setup do
      @user = Factory(:user)
      end
      
      should "return its full name" do
          assert_equal 'John Doe', @user.full_name
        end
      end
end
