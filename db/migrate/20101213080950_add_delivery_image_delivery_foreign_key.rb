class AddDeliveryImageDeliveryForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE delivery_images
        ADD CONSTRAINT delivery_image_delivery_foreign_key
        FOREIGN KEY (delivery_id)
        REFERENCES deliveries(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE delivery_images DROP FOREIGN KEY delivery_image_delivery_foreign_key
    }
  end
end
