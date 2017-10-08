require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
		@user = users(:juan_carlos)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty? , "it shouldn't show the flask message"
  end

  test "login with valid information" do
    get login_path

    post login_path, params: { session: { email: 		@user.email,
                                          password: 'juancho' } }
    assert_redirected_to @user
    
    follow_redirect!

    assert_template 'users/show'

    assert_select "a[href=?]", login_path, count: 0 # Asegurar que el boton de iniciar session ya no se encuentre
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'juancho' } }
    assert is_logged_in?, "No pudo iniciar session"
    assert_redirected_to @user , "No redirecciono al perfil del usuario"
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    
    delete logout_path
    assert_not is_logged_in?, "No cerro session correctamente"
    assert_redirected_to root_url, "No redirige al landing-page"
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

end
