class RemoveColumnsFromDeliveries < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE deliveries DROP FOREIGN KEY delivery_user_foreign_key
    }
    remove_columns(:deliveries, :summary, :user_id)
  end

  def self.down
    add_column(:deliveries, :summary, :text, :null => false)
    add_column(:deliveries, :user_id, :integer, :null => false)
    execute %{
      ALTER TABLE deliveries 
        ADD CONSTRAINT delivery_user_foreign_key
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end
end
