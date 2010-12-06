class Item < ActiveRecord::Base
  # item status 
  SUBMITTED = 0
  PICKED_UP = 1
  CHECKED_OUT = 2
  DELIVERED = 3
  WITHDRAWN = 4

  belongs_to :donation
  belongs_to :delivery

  validates_presence_of :donation_id, :category, :quantity
  validates_numericality_of :status, 
                            :greater_than_or_equal_to => SUBMITTED,
                            :less_than_or_equal_to => WITHDRAWN
end
