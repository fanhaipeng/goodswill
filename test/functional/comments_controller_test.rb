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

  test "comment can't be deleted if it doesn't belong to the donation" do
    assert_no_difference("Comment.count") do
      delete :destroy, :donation_id => donations(:donation_two), :id => comments(:comment_one).to_param
    end
    assert assigns(:comment).errors[:donation_id]
  end

end
