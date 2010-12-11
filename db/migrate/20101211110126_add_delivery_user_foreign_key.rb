class AddDeliveryUserForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE deliveries
        ADD CONSTRAINT delivery_user_foreign_key
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE deliveries DROP FOREIGN KEY delivery_user_foreign_key
    }
  end
end
