class AddUnitToItems < ActiveRecord::Migration
  def self.up
    add_column(:items, :unit, :string, :limit => 20, :null => true)
  end

  def self.down
    remove_column(:items, :unit)
  end
end
