require 'test_helper'

class AccountControllerTest < ActionController::TestCase
  test "show login page should be ok" do
    get :login
    assert_response :success 
    assert assigns(:sub_title)
  end

  test "login should be ok" do
    post :login, :user => {:email => 'one@goodswill.info', :password => 'passone'}
    assert session[:user_id], users(:user_one).id
    assert_redirected_to home_index_path
  end

  test "wrong password should fail login" do
    post :login, :user => {:email => 'one@goodswill.info', :password => 'wrong !!!'}
    assert !session[:user_id]
    assert_response :success
    assert_equal 'invalid email or password', flash[:notice]
  end

  test "logout should be ok" do
    session[:user_id] = users(:user_one).id
    post :logout
    assert_response :success
    assert !session[:user_id]
  end

  test "logout can't be called not logged in" do
    post :logout
    assert_redirected_to account_login_path
    assert_equal 'please log in', flash[:notice]
  end

end
