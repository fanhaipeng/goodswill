class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table (:users, :options => 'CHARSET=utf8') do |t|
      t.string :email, :limit => 50, :null => false
      t.string :hashed_password, :null => false
      t.string :salt, :null => false
      t.string :name, :limit => 50, :null => false
      t.integer :role, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
