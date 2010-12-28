class Delivery < ActiveRecord::Base

  OPEN = 0
  PACKED = 1
  SHIPPED = 2
  CONFIRMED = 3

  has_many :items
  belongs_to :receiver
  has_many :images, :class_name => 'DeliveryImage'
  has_many :notes, :class_name => 'DeliveryNote'

  validates_presence_of :receiver_id
  validates_inclusion_of :status, :in => [OPEN, PACKED, SHIPPED, CONFIRMED]
end
