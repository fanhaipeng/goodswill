require 'test_helper'

class DonationTest < ActiveSupport::TestCase

  test "fields except note must not be blank." do
    donation = Donation.new
    assert !donation.valid?

    assert donation.errors[:phone].any?
    assert donation.errors[:email].any?
    assert donation.errors[:name].any?

    # fields which have default values
    assert !donation.errors[:pick_up].any?
    assert !donation.errors[:news_letter].any?
    assert !donation.errors[:note].any?
  end

  test "phone must follow cell number rule" do
    donation = Donation.new(
      :address => 'any address',
      :email => 'name@example.com',
      :name => 'Tom White')
    
    err_msg = "format is invalid"

    # cell phone number, start with 1 & has 11 digits
    donation.phone = '1381234567'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:phone].to_s

    donation.phone = '138123456789'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:phone].to_s

    donation.phone = '23812345678'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:phone].to_s

    donation.phone = '13811189153'
    assert donation.valid?

    # telephone, follows area-number, area has 2 to 4 digits
    # and number has 7 or 8 digits
    donation.phone = '12345-1234567'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:phone].to_s

    donation.phone = '1-1234567'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:phone].to_s

    donation.phone = '12-1234567'
    assert donation.valid?

    donation.phone = '1234-1234567'
    assert donation.valid?

    donation.phone = '1234-123456'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:phone].to_s

    donation.phone = '1234-123456789'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:phone].to_s

    donation.phone = '1234-12345678'
    assert donation.valid?

    donation.phone = '1234-abc1234'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:phone].to_s
  end

  test "email address must be valid" do
    donation = Donation.new(
      :address => 'any address',
      :phone => '010-59173532',
      :name => 'Tom White')

    err_msg = "format is invalid"

    donation.email = 'abcd'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:email].to_s

    donation.email = 'goodswill@live.com'
    assert donation.valid?
  end

  test "status must be 0 to 2" do
    donation = create_valid_donation

    donation.status = -1
    assert !donation.valid?
    donation.status = 3
    assert !donation.valid?

    donation.status = 0 
    assert donation.valid?
    donation.status = 2
    assert donation.valid?
  end

  test "donation has many items" do
    donation = create_valid_donation
    assert donation.items
  end

  test "donation has many comments" do
    donation = create_valid_donation
    assert donation.comments
  end

  test "donation has many donation images" do
    donation = create_valid_donation
    assert donation.images
  end

  test "donation has many donation notes" do
    donation = create_valid_donation
    assert donation.notes
  end

private

  def create_valid_donation
    donation = Donation.new(
      :address => 'any address',
      :phone => '010-59173532',
      :email => 'goodswill@live.com',
      :name => 'Haipeng Fan')
    assert donation.valid?
    donation
  end
end
