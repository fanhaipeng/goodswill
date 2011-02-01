class DeliveryImage < ActiveRecord::Base
  belongs_to :delivery

  validate :validate_data
  validates_presence_of :image_type, :data

  attr_accessor :image_data

  def validate_data
    if image_data
      if self.image_data.size > 524288 # 512KB
        errors.add(:data, "must be smaller than 512KB")
      else
        self.data = image_data.read
        self.image_type = self.image_data.content_type.chomp
      end
    end
  end
end
