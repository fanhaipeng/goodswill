class AddItemNotesUserForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE item_notes
        ADD CONSTRAINT item_notes_user_foreign_key
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE item_notes DROP FOREIGN KEY item_notes_user_foreign_key
    }
  end
end
