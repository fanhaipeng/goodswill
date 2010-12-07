class Donation < ActiveRecord::Base
  has_many :items
  has_many :comments
  has_and_belongs_to_many :images

  accepts_nested_attributes_for :items, :allow_destroy => true

  validates_presence_of :phone, :address, :email, :name
  validates_format_of :phone, 
                      :with => /^1\d{10}$|^\d{2,4}-\d{7,8}$/,
                      :message => 'the phone number is invalid'
  validates_format_of :email,
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                      :message => 'email address is invalid'
end
