require 'test_helper'

class NewsControllerTest < ActionController::TestCase

  fixtures :news

  test "index of news should be ok" do
    get :index
    assert_response :success 
    assert assigns(:all_news)
  end

  test "new of news should be ok" do
    session[:user_id] = users(:user_two)
    get :new
    assert_response :success
    assert assigns(:news)
  end

  test "create news should be ok" do
    session[:user_id] = users(:user_two)
    assert_difference("News.count") do
      post :create, :news => { :title => 'any titile', :content => 'any text' }
    end
    assert assigns(:news)
    assert_redirected_to news_path(assigns(:news))
  end

  test "edit news should be ok" do
    session[:user_id] = users(:user_two)
    get :edit, :id => news(:news_one)
    assert_response :success
    assert_equal news(:news_one), assigns(:news)
  end

  test "update news should be ok" do
    session[:user_id] = users(:user_two)
    put :update, :id => news(:news_one), :news => { :title => 'new title', :content => 'new content' }
    assert_redirected_to news_path(news(:news_one))
  end

  test "show one piece of news should be ok" do
    get :show, :id => news(:news_one)
    assert_response :success
    assert_equal news(:news_one), assigns(:news)
  end

  test "delete one piece of news should be ok" do
    session[:user_id] = users(:user_two)
    assert_difference("News.count", -1) do
      delete :destroy, :id => news(:news_one)
    end
    assert_redirected_to news_index_path
  end

  test "anonymous user can't see new page" do
    get :new
    assert_redirected_to account_login_path
  end

  test "anonymous user can't create news" do
    assert_no_difference("News.count") do
      post :create, :news => { :title => 'any titile', :content => 'any text' }
    end
    assert_redirected_to account_login_path
  end

  test "anonymous user can't see edit page" do
    get :edit, :id => news(:news_one)
    assert_redirected_to account_login_path
  end

  test "anonymous user can't update news" do
    put :update, :id => news(:news_one), :news => { :title => 'new title', :content => 'new content' }
    assert_redirected_to account_login_path
  end

  test "anonymous user can't delete news" do
    assert_no_difference("News.count") do
      delete :destroy, :id => news(:news_one)
    end
    assert_redirected_to account_login_path
  end
end
