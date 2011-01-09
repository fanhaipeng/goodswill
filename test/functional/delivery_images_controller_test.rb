require 'test_helper'

class DeliveryImagesControllerTest < ActionController::TestCase
  test "create delivery image should be ok" do
    session[:user_id] = users(:user_two)
    assert_difference("DeliveryImage.count") do
      post :create, :delivery_id => deliveries(:delivery_one), :delivery_image => { :image_data => fixture_file_upload('files/test1.jpg', 'image/jpeg')}
    end 
    assert assigns(:img)
    assert_equal assigns(:img).delivery_id, deliveries(:delivery_one).id 
    assert_redirected_to delivery_path(deliveries(:delivery_one))
  end

  test "show delivery image should be ok" do
    get :show, :delivery_id => deliveries(:delivery_one), :id => delivery_images(:delivery_image_one)
    assert_response :success
  end

  test "delete delivery image should be ok" do
    session[:user_id] = users(:user_two)
    assert_difference("DeliveryImage.count", -1) do
      delete :destroy, :delivery_id => deliveries(:delivery_one), :id => delivery_images(:delivery_image_one)
    end
    assert_redirected_to delivery_path(deliveries(:delivery_one))
  end

  test "anonymous user can't create delivery image" do
    assert_no_difference("DeliveryImage.count") do
      post :create, :delivery_id => deliveries(:delivery_one), :delivery_image => { :image_data => fixture_file_upload('files/test1.jpg', 'image/jpeg')}
    end 
    assert_redirected_to account_login_path
  end

  test "anonymous user can't delete delivery image" do 
    assert_no_difference("DeliveryImage.count") do
      delete :destroy, :delivery_id => deliveries(:delivery_one), :id => delivery_images(:delivery_image_one)
    end
    assert_redirected_to account_login_path
  end
end
