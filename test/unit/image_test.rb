require 'test_helper'

class ImageTest < ActiveSupport::TestCase

  test "fields must not be blank" do
    img = Image.new
    assert !img.valid?

    assert img.errors[:image_type].any?
    assert img.errors[:data].any?
    assert img.errors[:description].any?
  end

end
