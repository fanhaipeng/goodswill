class News < ActiveRecord::Base
  has_many :images, :class_name => "NewsImage"
  validates_presence_of :title, :content
end
