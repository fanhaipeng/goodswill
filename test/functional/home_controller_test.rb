require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "index of home should be ok" do
    get :index
    assert_response :success
    assert assigns(:latest_news)
    assert assigns(:latest_items)
    assert assigns(:sub_title)
  end
end
