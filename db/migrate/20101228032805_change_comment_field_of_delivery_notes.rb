class ChangeCommentFieldOfDeliveryNotes < ActiveRecord::Migration
  def self.up
    rename_column(:delivery_notes, :comment, :note)
    change_column(:delivery_notes, :note, :text, :null => false)
  end

  def self.down
    change_column(:delivery_notes, :note, :text, :null => true)
    rename_column(:deliery_notes, :note, :comment)
  end
end
