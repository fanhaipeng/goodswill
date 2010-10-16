class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table (:deliveries, :options => 'CHARSET=utf8') do |t|
      t.integer :receiver_id, :null => false
      t.text :summary, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
