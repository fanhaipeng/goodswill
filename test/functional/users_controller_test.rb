require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "index of users should be ok" do
    session[:user_id] = users(:user_one).id
    get :index
    assert_response :success
    assert assigns(:users)
  end

  test "non super user can't see index" do
    test_super_user_required :index
  end

  test "new user should be ok" do
    session[:user_id] = users(:user_one).id
    get :new
    assert_response :success
    assert assigns(:user)
  end

  test "non super user can't see new page" do
    test_super_user_required :new
  end

  test "create a user should be ok" do
    session[:user_id] = users(:user_one).id
    assert_difference("User.count") do
      post :create, :user => { :role => 1, :name => 'any name', :email => 'abc@goodswill.info', :password => 'pass', :password_confirmation => 'pass'}
    end
    assert assigns(:user)
    assert_redirected_to user_path(assigns(:user))
  end

  test "non super user can't create user" do
    assert_no_difference("User.count") do
      post :create, :user => { :role => 1, :name => 'any name', :email => 'abc@goodswill.info', :password => 'pass', :password_confirmation => 'pass'}
    end
    assert_redirected_to account_login_path
    super_user_login_notice
  end

  test "new page is returned when create failed" do
    session[:user_id] = users(:user_one).id
    assert_no_difference("User.count") do
      post :create, :user => { :role => 1, :name => 'name', :email => 'aaa@goodswill.info', :password => 'thispass', :password_confirmation => 'thatpass' }
    end
    assert_response :success
  end

  test "show a user should be ok" do
    session[:user_id] = users(:user_two).id
    get :show, :id => users(:user_one)
    assert_response :success
    assert assigns(:user)
    assert assigns(:user).id, users(:user_one).id
  end

  test "anonymous user can't see show page" do
    get :show, :id => users(:user_one)
    assert_redirected_to account_login_path
  end

  test "delete a user should be ok" do
    session[:user_id] = users(:user_one).id
    assert_difference("User.count", -1) do
      delete :destroy, :id => users(:user_one)
    end
    assert_redirected_to users_path
  end

  test "non super user can't delete user" do
    assert_no_difference("User.count") do
      delete :destroy, :id => users(:user_one)
    end
    assert_redirected_to account_login_path
    super_user_login_notice
  end

  private

  def test_super_user_required page
    get page
    assert_redirected_to account_login_path

    session[:user_id] = users(:user_two)
    get page
    assert_redirected_to account_login_path
    super_user_login_notice
  end

  def super_user_login_notice
    assert 'please login as super user', flash[:notice]
  end
end
