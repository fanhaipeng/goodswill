class Donation < ActiveRecord::Base
  has_many :items
  has_many :comments
  has_many :images, :class_name => 'DonationImage'

  accepts_nested_attributes_for :items, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :phone, :address, :email, :name 
  validates_inclusion_of :pick_up, :discard, :news_letter, :in => [true, false]
  validates_format_of :phone, 
                      :with => /^1\d{10}$|^\d{2,4}-\d{7,8}$/,
                      :message => 'the phone number is invalid'
  validates_format_of :email,
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                      :message => 'email address is invalid'
end
