class RemoveItemNotesTable < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE item_notes DROP FOREIGN KEY item_notes_user_foreign_key
    }
    drop_table :item_notes
  end

  def self.down
    create_table(:item_notes, :options => "CHARSET=utf8 ENGINE=InnoDB") do |t|
      t.belongs_to :user, :null => false
      t.integer :status, :null => false, :default => 0
      t.text :note
      t.timestamps
    end
    execute %{
      ALTER TABLE item_notes
        ADD CONSTRAINT item_notes_user_foreign_key
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end
end
