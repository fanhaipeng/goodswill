require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  fixtures :donations

  test "fields must not be blank except deliveryid and status" do
    item = Item.new
    assert !item.valid?
    assert item.errors[:category].any?
    assert item.errors[:quantity].any?
  end

  test "default status should be initial" do
    item = Item.new(
      :donation => donations(:donation_one),
      :category => 'clothe',
      :quantity => 1)

    assert item.valid?
    assert_equal item.status, Item::NORMAL
  end

  test "status must be 0 to 1" do
    item = create_valid_item

    item.status = -1
    assert !item.valid?

    item.status =2 
    assert !item.valid?

    item.status =0 
    assert item.valid?
    
    item.status =1 
    assert item.valid?
  end

  test "item belongs to a donation" do
    item = create_valid_item
    item.donation = Donation.new
    assert item.donation
  end

  test "item belongs to a delivery" do
    item = create_valid_item
    item.delivery = Delivery.new
    assert item.delivery
  end

  private

  def create_valid_item
    item = Item.new(
      :donation_id => 0,
      :category => 'clothe',
      :quantity => 1)
    assert item.valid?
    item
  end
end
