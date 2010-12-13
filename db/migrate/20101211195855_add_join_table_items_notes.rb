class AddJoinTableItemsNotes < ActiveRecord::Migration
  def self.up
    create_table(:items_notes, :id => false, :options => "CHARSET=utf8 ENGINE=InnoDB") do |t|
      t.references :item
      t.references :item_note
    end
  end

  def self.down
    drop_table :items_notes
  end
end
