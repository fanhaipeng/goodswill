class AddDeliveryNoteDeliveryForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE delivery_notes
        ADD CONSTRAINT delivery_notes_delivery_foreign_key
        FOREIGN KEY (delivery_id)
        REFERENCES deliveries(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE delivery_notes DROP FOREIGN KEY delivery_notes_delivery_foreign_key
    }
  end
end
