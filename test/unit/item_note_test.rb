require 'test_helper'

class ItemNoteTest < ActiveSupport::TestCase

  fixtures :users

  test "user_id must not be blank" do
    item_note = ItemNotes.new
    assert !item_note.valid?
  end

  test "item note has many items" do
    item_note = create_valid_note 
    assert item_note.items
  end

  test "item note has the same status as item" do
    item_note = create_valid_note
    item_note.status = -1
    assert !item_note.valid?
    item_note.status = 0 
    assert item_note.valid?
    item_note.status = 4 
    assert item_note.valid?
    item_note.status = 5
    assert !item_note.valid?
  end

  private

  def create_valid_note
    item_note = ItemNotes.new
    item_note.user = users(:user_one)
    assert item_note.valid?
    item_note
  end
end
