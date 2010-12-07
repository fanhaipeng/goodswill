require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  test "create comment should be ok" do
    assert_difference("Comment.count") do
      post :create, :comment => { :comment => 'any text' }
    end
  end

end
