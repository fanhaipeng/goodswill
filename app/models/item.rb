class Item < ActiveRecord::Base
  # item status 
  INITIAL = 0
  PICKED = 1
  SORTED = 2
  WITHDREW = 3
  DISPOSED = 4

  belongs_to :donation
  belongs_to :delivery
  has_and_belongs_to_many :notes, :class_name => 'ItemNotes'

  validates_presence_of :category, :quantity
  validates_inclusion_of :status, :in => [INITIAL, PICKED, SORTED, WITHDREW, DISPOSED] 

end
