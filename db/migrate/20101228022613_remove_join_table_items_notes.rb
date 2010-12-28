class RemoveJoinTableItemsNotes < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE items_notes DROP FOREIGN KEY items_notes_item_foreign_key
    }
    execute %{
      ALTER TABLE items_notes DROP FOREIGN KEY items_notes_item_note_foreign_key
    }
    drop_table :items_notes
  end

  def self.down
    create_table(:items_notes, :id => false, :options => "CHARSET=utf8 ENGINE=InnoDB") do |t|
      t.references :item
      t.references :item_note
    end
    execute %{
      ALTER TABLE items_notes
        ADD CONSTRAINT items_notes_item_note_foreign_key
        FOREIGN KEY (item_note_id)
        REFERENCES item_notes(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
    execute %{
      ALTER TABLE items_notes
        ADD CONSTRAINT items_notes_item_foreign_key
        FOREIGN KEY (item_id)
        REFERENCES items(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end
end
