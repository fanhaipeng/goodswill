class CreateReceivers < ActiveRecord::Migration
  def self.up
    create_table (:receivers, :options => 'CHARSET=utf8') do |t|
      t.string :name, :limit => 50, :null => false
      t.text :introduction, :null => false
      t.string :address, :limit => 200
      t.string :phone, :limit => 20
      t.string :email, :limit => 50
      t.boolean :approved, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :receivers
  end
end
