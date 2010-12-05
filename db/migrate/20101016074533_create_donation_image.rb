class CreateDonationImage < ActiveRecord::Migration
  def self.up
    create_table :donations_images, :id => false, :options => 'CHARSET=utf8 ENGINE=InnoDB' do |t|
      t.integer :donation_id, :null => false
      t.integer :image_id, :null => false
    end
  end

  def self.down
    drop_table :donations_images
  end
end
