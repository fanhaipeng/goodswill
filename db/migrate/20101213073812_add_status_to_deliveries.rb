class AddStatusToDeliveries < ActiveRecord::Migration
  def self.up
    add_column(:deliveries, :status, :integer, :null => false, :default => 0)
  end

  def self.down
    remove_column(:deliveries, :status)
  end
end
