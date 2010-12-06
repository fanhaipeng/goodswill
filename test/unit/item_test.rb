require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "fields must not be blank except deliveryid and status" do
    item = Item.new
    assert !item.valid?
    assert item.errors[:donation_id].any?
    assert item.errors[:category].any?
    assert item.errors[:quantity].any?
  end

  test "default status should be submitted" do
    item = Item.new(
      :donation_id => 0,
      :category => 'clothe',
      :quantity => 1)

    assert item.valid?
    assert_equal item.status, Item::SUBMITTED
  end

  test "status must be 0 to 4" do
    item = Item.new(
      :donation_id => 0,
      :category => 'clothe',
      :quantity => 1)
    assert item.valid?

    item.status = -1
    assert !item.valid?

    item.status =5 
    assert !item.valid?

    item.status =0 
    assert item.valid?
    
    item.status =4 
    assert item.valid?
  end

  test "item belongs to a donation" do
    item = Item.new(
      :donation_id => 0,
      :category => 'clothe',
      :quantity => 1)
    assert item.valid?

    item.donation = Donation.new
    assert item.donation
  end

  test "item belongs to a delivery" do
    item = Item.new(
      :donation_id => 0,
      :category => 'clothe',
      :quantity => 1)
    assert item.valid?

    item.delivery = Delivery.new
    assert item.delivery
  end
end
