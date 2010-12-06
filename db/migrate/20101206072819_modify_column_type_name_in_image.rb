class ModifyColumnTypeNameInImage < ActiveRecord::Migration
  def self.up
    rename_column :images, :type, :image_type
  end

  def self.down
    rename_column :images, :image_type, :type
  end
end
