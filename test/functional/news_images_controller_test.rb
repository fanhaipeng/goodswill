require 'test_helper'

class NewsImagesControllerTest < ActionController::TestCase
  test "create news image should be ok" do
    assert_difference("NewsImage.count") do
      post :create, :news_id => news(:news_one), :news_image => { :description => 'new image', :image_data => fixture_file_upload('files/test1.jpg', 'image/jpeg')}
    end 
    assert assigns(:img)
    assert_equal assigns(:img).news_id, news(:news_one).id 
    assert_redirected_to news_path(news(:news_one))
  end

  test "show news image should be ok" do
    get :show, :news_id => news(:news_one), :id => news_images(:news_image_one)
    assert_response :success
  end

  test "delete news image should be ok" do
    assert_difference("NewsImage.count", -1) do
      delete :destroy, :news_id => news(:news_one), :id => news_images(:news_image_one)
    end
    assert_redirected_to news_path(news(:news_one))
  end

end
