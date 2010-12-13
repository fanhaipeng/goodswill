class RemoveOldJoinImagesTables < ActiveRecord::Migration
  def self.up
    drop_table :donations_images
    drop_table :deliveries_images
    drop_table :news_images
  end

  def self.down
  end
end
