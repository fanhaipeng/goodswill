require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  fixtures :donations

  test "fields must not be blank" do
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors[:donation_id].any?
    assert comment.errors[:comment].any?
  end

  test "donation_comment belongs to a donation" do
    comment = Comment.new(:comment => "any text")
    comment.donation = donations(:donation_one)
    assert comment.valid?
    assert comment.donation
  end
end
