class DonationImage < ActiveRecord::Base
  belongs_to :donation

  validates_presence_of :image_type, :data, :description
end
