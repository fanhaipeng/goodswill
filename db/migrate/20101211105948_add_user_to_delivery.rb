class AddUserToDelivery < ActiveRecord::Migration
  def self.up
    add_column(:deliveries, :user_id, :integer, :null => false)
  end

  def self.down
    remove_column(:deliveries, :user_id)
  end
end
