class RemoveStatusFromDeliveryNotes < ActiveRecord::Migration
  def self.up
    remove_column(:delivery_notes, :status)
  end

  def self.down
    add_column(:delivery_notes, :status, :integer, :null => false, :default => 0)
  end
end
