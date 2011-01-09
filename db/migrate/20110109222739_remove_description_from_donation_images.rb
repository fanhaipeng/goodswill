class RemoveDescriptionFromDonationImages < ActiveRecord::Migration
  def self.up
    remove_column(:donation_images, :description)
  end

  def self.down
    add_column(:donation_images, :description, :string, :limit => 50, :null => false)
  end
end
