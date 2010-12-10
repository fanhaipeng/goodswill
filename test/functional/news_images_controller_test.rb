require 'test_helper'

class NewsImagesControllerTest < ActionController::TestCase
  
  fixtures :news

  test "create news image should be ok" do
    assert_difference("Image.count") do
      post :create, :news_id => news(:news_one), 
       :image => { :image_type => 'image/jpeg', 
                   :data => [0xa, 0xb], 
                   :description => 'any text' } 
    end
    assert_redirected_to news_path(news(:news_one))
    assert assigns(:news)
  end

  test "show news image should be ok" do
    get :show, :news_id => news(:news_one), :id => images(:image_three)
    assert_response :success
  end

  test "delete news image should be ok" do
    assert_difference("Image.count", -1) do
      delete :destroy, :news_id => news(:news_one), :id => images(:image_one)
    end
    assert_redirected_to news_path(news(:news_one))
  end
end
