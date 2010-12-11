require 'test_helper'

class ImagesControllerTest < ActionController::TestCase

  fixtures :images

  test "show image should be ok" do
    get :show, :id => images(:image_one)
    assert_response :success
  end
end
