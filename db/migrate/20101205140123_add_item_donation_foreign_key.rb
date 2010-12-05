class AddItemDonationForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
    ALTER TABLE items 
      ADD CONSTRAINT item_donation_foreign_key
      FOREIGN KEY (donation_id)
      REFERENCES donations(id)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE expense_tags DROP FOREIGN KEY item_donation_foreign_key
    }
  end
end
