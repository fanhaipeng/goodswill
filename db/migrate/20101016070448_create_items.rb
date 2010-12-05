class CreateItems < ActiveRecord::Migration
  def self.up
    create_table (:items, :options => 'CHARSET=utf8 ENGINE=InnoDB') do |t|
      t.integer :donation_id, :null => false
      t.integer :delivery_id, :null => false
      t.string :category, :limit => 20, :null => false
      t.integer :quantity, :null => false
      t.integer :status, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
