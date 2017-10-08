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
end
