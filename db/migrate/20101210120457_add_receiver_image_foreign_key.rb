class AddReceiverImageForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE receivers
        ADD CONSTRAINT receiver_image_foreign_key
        FOREIGN KEY (image_id)
        REFERENCES images(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE receivers DROP FOREIGN KEY receiver_image_foreign_key
    }
  end
end
