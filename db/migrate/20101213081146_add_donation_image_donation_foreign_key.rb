class AddDonationImageDonationForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE donation_images
        ADD CONSTRAINT donation_image_donation_foreign_key
        FOREIGN KEY (donation_id)
        REFERENCES donations(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE donation_images DROP FOREIGN KEY donation_image_donation_foreign_key
    }
  end
end
