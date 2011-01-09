require 'test_helper'

class DeliveryImageTest < ActiveSupport::TestCase
  test "fields should not be blank" do
    img = DeliveryImage.new
    assert !img.valid?
    assert img.errors[:data].any?
    assert img.errors[:image_type].any?

    img.image_type = 'image/png'
    img.data = [0xa, 0xb]
  end
end
