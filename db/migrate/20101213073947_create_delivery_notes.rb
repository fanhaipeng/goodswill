class CreateDeliveryNotes < ActiveRecord::Migration
  def self.up
    create_table :delivery_notes, :options => "CHARSET=utf8 ENGINE=InnoDB" do |t|
      t.references :user
      t.references :delivery 
      t.text :comment
      t.integer :status, :null => false, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :delivery_notes
  end
end
