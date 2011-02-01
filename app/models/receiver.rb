class Receiver < ActiveRecord::Base
  has_many :delivery

  validates_presence_of :name, :introduction, :address, :phone, :email 
  validates_format_of :email, 
                      :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
                      :message => 'format is invalid'
  validates_format_of :phone,
                      :with => /^1\d{10}$|^\d{2,4}-\d{7,8}$/,
                      :message => 'format is invalid'

end
