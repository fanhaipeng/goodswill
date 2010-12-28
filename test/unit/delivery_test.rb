require 'test_helper'

class DeliveryTest < ActiveSupport::TestCase
  test "fields should not be blank" do
    delivery = Delivery.new
    assert !delivery.valid?
    assert delivery.errors[:receiver_id].any?
  end

  test "delivery has many items, images and notes" do
    delivery = Delivery.new(:receiver_id => receivers(:receiver_one).id)  
    assert delivery.valid?
    assert delivery.items
    assert delivery.images
    assert delivery.notes
  end

  test "delivery's status must between 0 and 3" do
    delivery = Delivery.new(:receiver_id => receivers(:receiver_one).id)  
    assert delivery.valid?

    delivery.status = -1
    assert !delivery.valid?
    delivery.status = 4 
    assert !delivery.valid?

    delivery.status = 0 
    assert delivery.valid?
    delivery.status = 3 
    assert delivery.valid?
  end

end
