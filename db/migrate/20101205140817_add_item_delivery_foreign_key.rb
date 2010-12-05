class AddItemDeliveryForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE items 
        ADD CONSTRAINT item_delivery_foreign_key
        FOREIGN KEY (delivery_id)
        REFERENCES deliveries(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE items DROP FOREIGN KEY item_delivery_foreign_key
    }
  end
end
