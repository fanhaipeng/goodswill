class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table (:donations, :options => 'CHARSET=utf8') do |t|
      t.string :phone, :limit => 20, :null => false
      t.string :address, :limit => 20, :null => false 
      t.string :email, :limit => 50, :null => false
      t.string :name, :limit => 50, :null => false
      t.boolean :track, :default => false
      t.text :details
      t.timestamps
    end
  end

  def self.down
    drop_table :donations
  end
end
