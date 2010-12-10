require 'test_helper'

class DonationImagesControllerTest < ActionController::TestCase

  fixtures :donations
  fixtures :images

  test "create image for donation should be ok" do
    assert_difference("Image.count") do
      post :create, :donation_id => donations(:donation_one), 
           :image => { :image_type => 'image/jpeg', 
                       :data => [0xa, 0xb], 
                       :description => 'any text' }
    end
    assert_redirected_to donation_path(donations(:donation))
    assert assigns(:donation)
  end

  test "show image for donation should be ok" do
    get :show, :donation_id => donations(:donation_one), :id => images(:image_one)
    assert_response :success
  end

  test "delete donation should be ok" do
    assert_difference("Image.count", -1) do
      delete :destroy, :donation_id => donations(:donation_one), :id => images(:image_one)
    end
    assert_redirected_to donation_path(donations(:donation_one))
  end

end

