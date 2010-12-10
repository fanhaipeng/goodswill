class News < ActiveRecord::Base
  has_and_belongs_to_many :images, :join_table => 'news_images'
  validates_presence_of :title, :content
end
