class CreateDonationImages < ActiveRecord::Migration
  def self.up
    create_table :donation_images, :options => "CHARSET=utf8 ENGINE=InnoDB" do |t|
      t.references :donation
      t.string :image_type, :limit => 20, :null => false
      t.binary :data, :limit => 1.megabyte, :null => false
      t.string :description, :limit => 50, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :donation_images
  end
end
