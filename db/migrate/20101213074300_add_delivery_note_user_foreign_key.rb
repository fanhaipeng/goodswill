class AddDeliveryNoteUserForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE delivery_notes
        ADD CONSTRAINT delivery_notes_user_foreign_key
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE delivery_notes DROP FOREIGN KEY delivery_notes_user_foreign_key
    }
  end
end
