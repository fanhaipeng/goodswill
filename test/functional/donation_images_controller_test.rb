require 'test_helper'

class DonationImagesControllerTest < ActionController::TestCase

  fixtures :donation_images

  test "show donation image should be ok" do
    get :show, :id => donation_images(:donation_image_one)
    assert_response :success
  end

end

