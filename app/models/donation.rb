class Donation < ActiveRecord::Base
  validates_presence_of :phone, :address, :email, :name
  validates_format_of :phone, 
                      :with => /^1\d{10}$|^\d{2,4}-\d{7,8}$/,
                      :message => 'the phone number is invalid'
  validates_format_of :email,
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                      :message => 'email address is invalid'

end
