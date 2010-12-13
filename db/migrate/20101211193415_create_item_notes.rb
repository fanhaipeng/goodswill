class CreateItemNotes < ActiveRecord::Migration
  def self.up
    create_table(:item_notes, :options => "CHARSET=utf8 ENGINE=InnoDB") do |t|
      t.belongs_to :user, :null => false
      t.integer :status, :null => false, :default => 0
      t.text :note
      t.timestamps
    end
  end

  def self.down
    drop_table :item_notes
  end
end
