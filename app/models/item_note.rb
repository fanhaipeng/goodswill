class ItemNote < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :items, :join_table => 'items_notes'
  validates_presence_of :user_id
  validates_inclusion_of :status, :in => [Item::INITIAL, Item::PICKED, Item::SORTED, Item::WITHDREW, Item::DISPOSED]
end
