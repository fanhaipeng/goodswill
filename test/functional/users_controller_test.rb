require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "index of users should be ok" do
    get :index
    assert_response :success
    assert assigns(:users)
  end

  test "new user should be ok" do
    get :new
    assert_response :success
    assert assigns(:user)
  end

  test "create a user should be ok" do
    assert_difference("User.count") do
      post :create, :user => { :role => 1, :name => 'any name', :email => 'abc@goodswill.info', :password => 'pass', :password_confirmation => 'pass'}
    end
    assert assigns(:user)
    assert_redirected_to user_path(assigns(:user))
  end

  test "new page is returned when create failed" do
    assert_no_difference("User.count") do
      post :create, :user => { :role => 1, :name => 'name', :email => 'aaa@goodswill.info', :password => 'thispass', :password_confirmation => 'thatpass' }
    end
    assert_response :success
  end

  test "show a user should be ok" do
    get :show, :id => users(:user_one)
    assert_response :success
    assert assigns(:user)
    assert assigns(:user).id, users(:user_one).id
  end

  test "delete a user should be ok" do
    assert_difference("User.count", -1) do
      delete :destroy, :id => users(:user_one)
    end
    assert_redirected_to users_path
  end
end
