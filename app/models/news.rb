class News < ActiveRecord::Base
  has_many :news_images
  validates_presence_of :title, :content
end
