class RemoveDiscardFromDonations < ActiveRecord::Migration
  def self.up
    remove_column(:donations, :discard)
  end

  def self.down
    add_column(:donations, :discard, :boolean, :null => false, :default => true)
  end
end
