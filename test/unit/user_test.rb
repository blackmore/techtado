require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  context "create a new user" do
    setup do
      @user = Factory(:user)
    end

    should_have_db_column :last_name, :type => "string", :default => nil
    should "test full name block" do
    assert_equal('John Doe', @user.full_name)
    end

  end
  
  should "be true" do
    assert true
  end
end
