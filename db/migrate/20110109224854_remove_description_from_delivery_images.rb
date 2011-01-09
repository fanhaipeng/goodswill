class RemoveDescriptionFromDeliveryImages < ActiveRecord::Migration
  def self.up
    remove_column(:delivery_images, :description)
  end

  def self.down
    add_column(:delivery_images, :description, :string, :limit => 50, :null => false)
  end
end
