require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "fields must not be blank" do
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors[:donation].any?
    assert comment.errors[:comment].any?
  end

  test "donation_comment belongs to a donation" do
    comment = Comment.new(:comment => "any text")
    comment.donation = Donation.new(
      :address => 'any address',
      :phone => '010-59173532',
      :email => 'goodswill@live.com',
      :name => 'Haipeng Fan')
    assert comment.valid?
    assert comment.donation
  end
end
