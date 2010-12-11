class ChangeDonations < ActiveRecord::Migration
  def self.up
    change_table(:donations) do |t|
      t.remove :details
      t.remove :track
      t.column :pick_up, :boolean, :null => false, :default => false
      t.column :discard, :boolean, :null => false, :default => true
      t.column :news_letter, :boolean, :null => false, :default => true
      t.column :note, :text, :null => true
    end
  end

  def self.down
    change_table(:donations) do |t|
      t.remove :note
      t.remove :news_letter
      t.remove :discard
      t.remove :pick_up
      t.column :track, :boolean, :default => false
      t.column :details, :text, :null => true
    end
  end
end
