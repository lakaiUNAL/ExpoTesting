require "application_system_test_case"

class StaticPagesTest < ApplicationSystemTestCase
   test "Create user" do
     visit about_url
  
     assert_selector "h1", text: "About page"
     assert_selector "a", text: "RUby on rails tutorial" #modify error here
     visit singup_url
     assert_selector 'h1', 'Sign up'
     assert_selector 'form' do
      assert_selector 'input#user_name'
      assert_selector 'input#user_email'
      assert_selector 'input#user_password'
      assert_selector 'input#user_password_confirmation'
      
    fill_in "Name", with: 'David'
    fill_in "Email", with: 'david@mail.com'
    fill_in "Password", with: 'secret'
    fill_in "Confirmation", with: 'secret'
    
    click_on "Create my account"
    #assert_selector 'h1', text: user_attributes_name
    assert_selector 'div', text: 'Welcome to the Sample App!'
    assert_selector 'h1', text: 'David'
    end
   end
end
