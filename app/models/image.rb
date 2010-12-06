class Image < ActiveRecord::Base
  # image types
  JPEG = 'images/jpeg'
  PNG = 'images/png'

  validates_presence_of :image_type, :data, :description
  validates_format_of :image_type, :with => Regexp.new(JPEG << "|" << PNG)
end
