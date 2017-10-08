require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "Invalid Sing Up Information" do
    #Assert 
    get singup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end

    #Assert the new layout will be rendered
    assert_template 'users/new'

    #Assert the error message is appearing
    assert_select 'div#error_explanation'
    #assert_select 'div.<CSS class for field with error>'
  end

  test "valid signup information" do
    
    #get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'

    assert_not flash.empty?

    #assert_select ".success"
    assert_select ".alert-success"

  end

end
