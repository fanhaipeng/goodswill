require 'test_helper'

class NewsControllerTest < ActionController::TestCase

  fixtures :news

  test "index of news should be ok" do
    get :index
    assert_response :success 
    assert assigns(:all_news)
  end

  test "new of news should be ok" do
    get :new
    assert_response :success
    assert assigns(:news)
  end

  test "create news should be ok" do
    assert_difference("News.count") do
      post :create, :news => { :title => 'any titile', :content => 'any text' }
    end
    assert assigns(:news)
    assert_redirected_to news_path(assigns(:news))
  end

  test "edit news should be ok" do
    get :edit, :id => news(:news_one)
    assert_response :success
    assert_equal news(:news_one), assigns(:news)
  end

  test "update news should be ok" do
    put :update, :id => news(:news_one), :news => { :title => 'new title', :content => 'new content' }
    assert_redirected_to news_path(news(:news_one))
  end

  test "show one piece of news should be ok" do
    get :show, :id => news(:news_one)
    assert_response :success
    assert_equal news(:news_one), assigns(:news)
  end

  test "delete one piece of news should be ok" do
    assert_difference("News.count", -1) do
      delete :destroy, :id => news(:news_one)
    end
    assert_redirected_to news_index_path
  end
end
