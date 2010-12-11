require 'test_helper'

class ReceiverTest < ActiveSupport::TestCase

  test "fields must not be blank" do
    receiver = Receiver.new
    assert !receiver.valid?
    assert receiver.errors[:name].any?
    assert receiver.errors[:introduction].any?
    assert receiver.errors[:address].any?
    assert receiver.errors[:phone].any?
    assert receiver.errors[:email].any?

    receiver = create_valid_receiver
    assert receiver.valid?
  end

  test "email should be valid" do
    receiver = create_valid_receiver
    receiver.email = 'abc'
    assert !receiver.valid?
    assert receiver.errors[:email].any?

    receiver.email = 'goodswill@live.com'
    assert receiver.valid?
  end

  test "phone number should be valid" do
    receiver = create_valid_receiver

    valid_phone(receiver, '13812345678')
    valid_phone(receiver, '021-12345678')
    valid_phone(receiver, '10-12345678')
    valid_phone(receiver, '0936-1234567')

    invalid_phone(receiver, '23812345678')
    invalid_phone(receiver, '1381234567')
    invalid_phone(receiver, '138123456789')

    invalid_phone(receiver, '1-12345678')
    invalid_phone(receiver, '12345-12345678')
    invalid_phone(receiver, '010-123456')
    invalid_phone(receiver, '010-123456789')
  end

  private

  def create_valid_receiver
    receiver = Receiver.new(
      :name => 'any name',
      :introduction => 'any text',
      :address => 'any address',
      :phone => '13812345678',
      :email => 'goodswill@live.com',
      :image_file => 1)
  end

  def valid_phone(receiver, phone)
    receiver.phone = phone
    assert receiver.valid?
  end

  def invalid_phone(receiver, phone)
    receiver.phone = phone
    assert !receiver.valid?
    assert receiver.errors[:phone].any?
  end
end
