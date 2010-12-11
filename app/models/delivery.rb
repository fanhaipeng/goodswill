class Delivery < ActiveRecord::Base
  has_many :items
  has_one :receiver
  has_and_belongs_to_many :images
end
