class Donation < ActiveRecord::Base

  INITIAL = 0
  PICKED = 1
  SORTED = 2

  has_many :items
  has_many :comments
  has_many :images, :class_name => 'DonationImage'
  has_many :notes, :class_name => 'DonationNote'

  accepts_nested_attributes_for :items, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :phone, :email, :name, :status
  validates_inclusion_of :pick_up, :news_letter, :in => [true, false]
  validates_inclusion_of :status, :in => [INITIAL, PICKED, SORTED]
  validates_format_of :phone, 
                      :with => /^1\d{10}$|^\d{2,4}-\d{7,8}$/,
                      :message => 'format is invalid'
  validates_format_of :email,
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                      :message => 'format is invalid'
end
