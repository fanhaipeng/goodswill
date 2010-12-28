class AddStatusToDonations < ActiveRecord::Migration
  def self.up
    add_column(:donations, :status, :integer, :null => false, :default => 0)
  end

  def self.down
    remove_column(:donations, :status)
  end
end
