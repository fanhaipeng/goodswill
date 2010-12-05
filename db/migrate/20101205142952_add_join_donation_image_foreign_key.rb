class AddJoinDonationImageForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE donations_images 
        ADD CONSTRAINT join_donation_image_foreign_key
        FOREIGN KEY (donation_id)
        REFERENCES donations(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }

    execute %{
      ALTER TABLE donations_images 
        ADD CONSTRAINT join_image_donation_foreign_key
        FOREIGN KEY (image_id)
        REFERENCES images(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE donations_images DROP FOREIGN KEY join_donation_image_foreign_key
    }

    execute %{
      ALTER TABLE donations_images DROP FOREIGN KEY join_image_donation_foreign_key
    }
  end
end
