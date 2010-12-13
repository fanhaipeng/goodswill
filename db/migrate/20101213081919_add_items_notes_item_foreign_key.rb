class AddItemsNotesItemForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE items_notes
        ADD CONSTRAINT items_notes_item_foreign_key
        FOREIGN KEY (item_id)
        REFERENCES items(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE items_notes DROP FOREIGN KEY items_notes_item_foreign_key
    }
  end
end
