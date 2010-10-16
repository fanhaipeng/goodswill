class CreateNewsImages < ActiveRecord::Migration
  def self.up
    create_table :news_images, :id => false do |t|
      t.integer :news_id, :null => false
      t.integer :image_id, :null => false
    end
  end

  def self.down
    drop_table :news_images
  end
end
