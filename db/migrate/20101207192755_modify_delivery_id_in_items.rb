class ModifyDeliveryIdInItems < ActiveRecord::Migration
  def self.up
    change_column(:items, :delivery_id, :integer, :null => true)
  end

  def self.down
    change_column(:items, :delivery_id, :integer, :null => false)
  end
end
