class ChangeAddressOfDonationNullable < ActiveRecord::Migration
  def self.up
    change_column(:donations, :address, :string, :limit => 200, :null => true)
  end

  def self.down
    change_column(:donations, :address, :string, :limit => 20, :null => false)
  end
end
