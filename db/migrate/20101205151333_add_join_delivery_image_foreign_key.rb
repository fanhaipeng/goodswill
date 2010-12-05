class AddJoinDeliveryImageForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE deliveries_images 
        ADD CONSTRAINT join_delivery_image_foreign_key
        FOREIGN KEY (delivery_id)
        REFERENCES deliveries(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }

    execute %{
      ALTER TABLE deliveries_images 
        ADD CONSTRAINT join_image_delivery_foreign_key
        FOREIGN KEY (image_id)
        REFERENCES images(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE deliveries_images DROP FOREIGN KEY join_delivery_image_foreign_key
    }

    execute %{
      ALTER TABLE deliveries_images DROP FOREIGN KEY join_image_delivery_foreign_key
    }
  end
end
