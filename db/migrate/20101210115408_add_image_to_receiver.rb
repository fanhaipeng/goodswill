class AddImageToReceiver < ActiveRecord::Migration
  def self.up
    add_column(:receivers, :image_id, :integer, :null => true) 
  end

  def self.down
    remove_column(:receivers, :image_id)
  end
end
