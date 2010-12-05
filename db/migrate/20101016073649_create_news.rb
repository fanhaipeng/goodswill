class CreateNews < ActiveRecord::Migration
  def self.up
    create_table (:news, :options => 'CHARSET=utf8 ENGINE=InnoDB') do |t|
      t.string :title, :limit => 200, :null => false
      t.text :content, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
