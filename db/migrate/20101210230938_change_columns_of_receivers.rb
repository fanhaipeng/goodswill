class ChangeColumnsOfReceivers < ActiveRecord::Migration
  def self.up
    change_column(:receivers, :address, :string, :limit => 200, :null => false) 
    change_column(:receivers, :phone, :string, :limit => 20, :null => false)
    change_column(:receivers, :email, :string, :limit => 50, :null => false)
    change_column(:receivers, :image_id, :integer, :null => false)
  end

  def self.down
    change_column(:receivers, :image_id, :integer, :null => true)
    change_column(:receivers, :email, :string, :limit => 50, :null => true)
    change_column(:receivers, :phone, :string, :limit => 20, :null => true)
    change_column(:receivers, :address, :string, :limit => 200, :null => true) 
  end
end
