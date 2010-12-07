class RenameTableDonationComments < ActiveRecord::Migration
  def self.up
    rename_table('donation_comments', 'comments')
  end

  def self.down
    rename_table('comments', 'donation_comments')
  end
end
