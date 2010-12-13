class DonationImage < ActiveRecord::Base
  belongs_to :donation

  validates_presence_of :image_type, :data, :description

  before_validation :transform_data

  attr_accessor :image_data

  def transform_data
    if image_data
      self.data = image_data.read
      self.image_type = self.image_data.content_type.chomp
    end 
  end
end
