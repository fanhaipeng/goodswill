class Image < ActiveRecord::Base
  # image types
  JPEG = 'image/jpeg'
  PNG = 'image/png'

  validates_presence_of :image_type, :data, :description
  validates_format_of :image_type, :with => Regexp.new(JPEG << "|" << PNG)

  attr_accessor :image_data

  def self.before_validation
    if image_data
      self.data = image_data.read
      self.image_type = self.image_data.content_type.chomp
    end
  end

end
