class RemoveImageIdFromReceivers < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE receivers DROP FOREIGN KEY receiver_image_foreign_key
    }
    remove_column(:receivers, :image_id)
  end

  def self.down
    add_column(:receivers, :image_id, :integer, :null => false)
    execute %{
      ALTER TABLE receivers
        ADD CONSTRAINT receiver_image_foreign_key
        FOREIGN KEY (image_id)
        REFERENCES images(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end
end
