require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  fixtures :donations
  fixtures :comments

  test "create comment should be ok" do
    assert_difference("Comment.count") do
      post :create, :donation_id => donations(:donation_one).to_param, :comment => { :comment => 'any text' }
    end
  end

  test "delete comment should be ok" do
    assert_difference("Comment.count", -1) do
      delete :destroy, :donation_id => donations(:donation_one), :id => comments(:comment_one).to_param
    end
  end

end
