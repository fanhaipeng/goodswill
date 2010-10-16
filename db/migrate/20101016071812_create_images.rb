class CreateImages < ActiveRecord::Migration
  def self.up
    create_table (:images, :options => 'CHARSET=utf8') do |t| 
      t.string :type, :null => false
      t.binary :data, :limit => 1.megabyte, :null => false
      t.string :description, :limit => 100
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
