require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "index of users should be ok" do
    session[:user_id] = users(:user_one).id
    get :index
    assert_response :success
    assert assigns(:users)
    assert assigns(:current_user)
    assert users(:user_one).id, assigns(:current_user).id
  end

  test "non super user can't see index" do
    test_super_user_required :index
  end

  test "new user should be ok" do
    session[:user_id] = users(:user_one).id
    get :new
    assert_response :success
    assert assigns(:user)
    assert assigns(:current_user)
    assert users(:user_one).id, assigns(:current_user).id

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
    assert assigns(:current_user)
    assert users(:user_one).id, assigns(:current_user).id
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
    assert assigns(:current_user)
    assert assigns(:user).id, users(:user_two).id
  end

  test "anonymous user can't see show page" do
    get :show, :id => users(:user_one)
    assert_redirected_to account_login_path
  end

  test "user can see other user's information" do
    session[:user_id] = users(:user_two).id
    get :show, :id => users(:user_one).id
    assert_response :success
    assert assigns(:user)
    assert assigns(:user).id, users(:user_one).id
    assert assigns(:current_user)
    assert users(:user_two).id, assigns(:current_user).id
  end

  test "super user can see show page" do
    session[:user_id] = users(:user_one).id
    get :show, :id => users(:user_two)
    assert_response :success
    assert assigns(:user)
    assert users(:user_two).id, assigns(:user).id
    assert assigns(:current_user)
    assert users(:user_two).id, assigns(:current_user).id
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

  test "edit user's password should be ok" do
    session[:user_id] = users(:user_two).id
    get :edit, :id => users(:user_two).id.to_s
    assert_response :success
    assert assigns(:user)
    assert_equal users(:user_two).id, assigns(:user).id
  end

  test "anonymous user can't see edit page" do
    get :edit, :id => users(:user_two)
    assert_redirected_to account_login_path
  end

  test "user is not allowed to edit other user's password" do
    session[:user_id] = users(:user_one).id
    get :edit, :id => users(:user_two).id.to_s
    assert_response 401 # unauthorized
  end

  test "update user's password should be ok" do
    session[:user_id] = users(:user_two).id
    put :update, :id => users(:user_two).id.to_s, :user => { :password => 'newpass', :password_confirmation => 'newpass' }
    assert_redirected_to user_path(users(:user_two))
    assert_equal 'Password has been changed successfully', flash[:notice]
  end

  test "anonymous user can't update user" do
    put :update, :id => users(:user_two).id.to_s, :user => { :password => 'newpass', :password_confirmation => 'newpass' }
    assert_redirected_to account_login_path
  end

  test "user is not allowed to update other user's password" do
    session[:user_id] = users(:user_one)
    put :update, :id => users(:user_two).id.to_s, :user => { :password => 'newpass', :password_confirmation => 'newpass' }
    assert_response 401 # unauthorized
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
