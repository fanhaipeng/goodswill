class CreateDeliveriesImages < ActiveRecord::Migration
  def self.up
    create_table :deliveries_images, :id => false, :options => 'CHARSET=utf8 ENGINE=InnoDB' do |t|
      t.integer :delivery_id, :null => false
      t.integer :image_id, :null => false
    end
  end

  def self.down
    drop_table :deliveries_images
  end
end
