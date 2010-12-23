require 'test_helper'

class NewsImageTest < ActiveSupport::TestCase
  test "fields should not be blank" do
    img = NewsImage.new
    assert !img.valid?
    assert img.errors[:description].any?
    assert img.errors[:data].any?
    assert img.errors[:image_type].any?

    img.description = 'any text'
    img.image_type = 'image/png'
    img.data = [0xa, 0xb]
  end
end
