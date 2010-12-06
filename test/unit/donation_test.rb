require 'test_helper'

class DonationTest < ActiveSupport::TestCase

  test "fields except track and details must not be blank." do
    donation = Donation.new
    assert !donation.valid?

    assert donation.errors[:phone].any?
    assert donation.errors[:address].any?
    assert donation.errors[:email].any?
    assert donation.errors[:name].any?
  end

  test "phone must follow cell number rule" do
    donation = Donation.new(
      :address => 'any address',
      :email => 'name@example.com',
      :name => 'Tom White')
    
    err_msg = "the phone number is invalid"

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

    err_msg = "email address is invalid"

    donation.email = 'abcd'
    assert !donation.valid?
    assert_equal err_msg, donation.errors[:email].to_s

    donation.email = 'goodswill@live.com'
    assert donation.valid?
  end
end