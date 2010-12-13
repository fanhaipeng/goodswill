require 'test_helper'

class DonationImageTest < ActiveSupport::TestCase

  test "fields must not be blank" do
    dimg = DonationImage.new
    assert !dimg.valid?
    assert dimg.errors[:image_type].any?
    assert dimg.errors[:data].any?
    assert dimg.errors[:description].any?
  end
end
