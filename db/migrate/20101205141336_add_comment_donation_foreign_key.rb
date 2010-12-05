class AddCommentDonationForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE donation_comments
        ADD CONSTRAINT comment_donation_foreign_key
        FOREIGN KEY (donation_id)
        REFERENCES donation_comments(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE expense_tags DROP FOREIGN KEY comment_donation_foreign_key
    }
  end
end
