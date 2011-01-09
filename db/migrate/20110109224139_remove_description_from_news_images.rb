class RemoveDescriptionFromNewsImages < ActiveRecord::Migration
  def self.up
    remove_column(:news_images, :description)
  end

  def self.down
    add_column(:news_images, :description, :string, :limit => 50, :null => false)
  end
end
