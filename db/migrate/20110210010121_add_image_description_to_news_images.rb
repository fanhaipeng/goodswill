class AddImageDescriptionToNewsImages < ActiveRecord::Migration
  def self.up
    add_column(:news_images, :description, :string, :limit => 200, :null => true);
  end

  def self.down
    remove_column(:news_images, :description)
  end
end
