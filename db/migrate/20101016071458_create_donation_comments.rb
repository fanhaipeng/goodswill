class CreateDonationComments < ActiveRecord::Migration
  def self.up
    create_table (:donation_comments, :options => 'CHARSET=utf8') do |t|
      t.integer :donation_id, :null => false
      t.string :comment, :null => false, :limit => 500
      t.timestamps
    end
  end

  def self.down
    drop_table :donation_comments
  end
end
