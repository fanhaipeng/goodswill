class AddDeliveryReceiverForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE deliveries 
        ADD CONSTRAINT delivery_receiver_foreign_key
        FOREIGN KEY (receiver_id)
        REFERENCES receivers(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE deliveries DROP FOREIGN KEY delivery_receiver_foreign_key
    }
  end
end
