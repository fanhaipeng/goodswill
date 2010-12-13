class AddItemsNotesItemNoteForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE items_notes
        ADD CONSTRAINT items_notes_item_note_foreign_key
        FOREIGN KEY (item_note_id)
        REFERENCES item_notes(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE items_notes DROP FOREIGN KEY items_notes_item_note_foreign_key
    }
  end
end
