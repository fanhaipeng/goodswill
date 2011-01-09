class Item < ActiveRecord::Base
  # item status 
  NORMAL = 0
  DISPOSED = 1

  belongs_to :donation
  belongs_to :delivery

  validates_presence_of :category, :quantity
  validates_inclusion_of :status, :in => [NORMAL, DISPOSED] 

end
