# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101213082055) do

  create_table "comments", :force => true do |t|
    t.integer  "donation_id",                :null => false
    t.string   "comment",     :limit => 500, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["donation_id"], :name => "comment_donation_foreign_key"

  create_table "deliveries", :force => true do |t|
    t.integer  "receiver_id",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",      :default => 0, :null => false
  end

  add_index "deliveries", ["receiver_id"], :name => "delivery_receiver_foreign_key"

  create_table "delivery_images", :force => true do |t|
    t.integer  "delivery_id"
    t.string   "image_type",  :limit => 20,       :null => false
    t.binary   "data",        :limit => 16777215, :null => false
    t.string   "description", :limit => 50,       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delivery_images", ["delivery_id"], :name => "delivery_image_delivery_foreign_key"

  create_table "delivery_notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "delivery_id"
    t.text     "comment"
    t.integer  "status",      :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delivery_notes", ["delivery_id"], :name => "delivery_notes_delivery_foreign_key"
  add_index "delivery_notes", ["user_id"], :name => "delivery_notes_user_foreign_key"

  create_table "donation_images", :force => true do |t|
    t.integer  "donation_id"
    t.string   "image_type",  :limit => 20,       :null => false
    t.binary   "data",        :limit => 16777215, :null => false
    t.string   "description", :limit => 50,       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donation_images", ["donation_id"], :name => "donation_image_donation_foreign_key"

  create_table "donations", :force => true do |t|
    t.string   "phone",       :limit => 20,                    :null => false
    t.string   "address",     :limit => 20,                    :null => false
    t.string   "email",       :limit => 50,                    :null => false
    t.string   "name",        :limit => 50,                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pick_up",                   :default => false, :null => false
    t.boolean  "discard",                   :default => true,  :null => false
    t.boolean  "news_letter",               :default => true,  :null => false
    t.text     "note"
  end

  create_table "item_notes", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "status",     :default => 0, :null => false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_notes", ["user_id"], :name => "item_notes_user_foreign_key"

  create_table "items", :force => true do |t|
    t.integer  "donation_id",                              :null => false
    t.integer  "delivery_id"
    t.string   "category",    :limit => 20,                :null => false
    t.integer  "quantity",                                 :null => false
    t.integer  "status",                    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unit",        :limit => 20
  end

  add_index "items", ["delivery_id"], :name => "item_delivery_foreign_key"
  add_index "items", ["donation_id"], :name => "item_donation_foreign_key"

  create_table "items_notes", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "item_note_id"
  end

  add_index "items_notes", ["item_id"], :name => "items_notes_item_foreign_key"
  add_index "items_notes", ["item_note_id"], :name => "items_notes_item_note_foreign_key"

  create_table "news", :force => true do |t|
    t.string   "title",      :limit => 200, :null => false
    t.text     "content",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_images", :force => true do |t|
    t.integer  "news_id"
    t.string   "image_type",  :limit => 20,       :null => false
    t.binary   "data",        :limit => 16777215, :null => false
    t.string   "description", :limit => 50,       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_images", ["news_id"], :name => "news_image_news_foreign_key"

  create_table "receivers", :force => true do |t|
    t.string   "name",         :limit => 50,                     :null => false
    t.text     "introduction",                                   :null => false
    t.string   "address",      :limit => 200,                    :null => false
    t.string   "phone",        :limit => 20,                     :null => false
    t.string   "email",        :limit => 50,                     :null => false
    t.boolean  "approved",                    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",           :limit => 50, :null => false
    t.string   "hashed_password",               :null => false
    t.string   "salt",                          :null => false
    t.string   "name",            :limit => 50, :null => false
    t.integer  "role",                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
