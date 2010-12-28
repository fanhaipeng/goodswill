class Item < ActiveRecord::Base
  # item status 
  NORMAL = 0
  WITHDREW = 1
  DISPOSED = 2

  belongs_to :donation
  belongs_to :delivery

  validates_presence_of :category, :quantity
  validates_inclusion_of :status, :in => [NORMAL, WITHDREW, DISPOSED] 

end
