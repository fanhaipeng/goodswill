require 'test_helper'

class DonationCommentTest < ActiveSupport::TestCase
  test "fields must not be blank" do
    comment = DonationComment.new
    assert !comment.valid?
    assert comment.errors[:donation_id].any?
    assert comment.errors[:comment].any?
  end
end
