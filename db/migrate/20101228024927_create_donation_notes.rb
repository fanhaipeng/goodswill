class CreateDonationNotes < ActiveRecord::Migration
  def self.up
    create_table(:donation_notes, :options => "CHARSET=utf8 ENGINE=InnoDB") do |t|
      t.references :donation, :null => false
      t.references :user, :null => false
      t.text :note, :null => false
      t.timestamps
    end

    execute %{
      ALTER TABLE donation_notes
        ADD CONSTRAINT donation_notes_user_foreign_key
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }

    execute %{
      ALTER TABLE donation_notes
        ADD CONSTRAINT donation_notes_donation_foreign_key
        FOREIGN KEY (donation_id)
        REFERENCES donations(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE donation_notes DROP FOREIGN donation_notes_donation_foreign_key
    }
    execute %{
      ALTER TABLE donation_notes DROP FOREIGN KEY donation_notes_user_foreign_key
    }
    drop_table :donation_notes
  end
end
