require 'test_helper'

class ImageTest < ActiveSupport::TestCase

  test "fields must not be blank" do
    img = Image.new
    assert !img.valid?

    assert img.errors[:image_type].any?
    assert img.errors[:data].any?
    assert img.errors[:description].any?
  end

  test "only are jpeg and png supported" do
    img = Image.new(
      :image_type => Image::JPEG,
      :data => [0xa, 0xb],
      :description => 'any text')
    assert img.valid?

    img = Image.new(
      :image_type => Image::PNG,
      :data => [0xa, 0xb],
      :description => 'any text')
    assert img.valid?

    img = Image.new(
      :image_type => 'images/bmp',
      :data => [0xa, 0xb],
      :description => 'any text')
    assert !img.valid?
  end

end
