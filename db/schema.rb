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

ActiveRecord::Schema.define(:version => 20101205140817) do

  create_table "deliveries", :force => true do |t|
    t.integer  "receiver_id", :null => false
    t.text     "summary",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliveries_images", :id => false, :force => true do |t|
    t.integer "delivery_id", :null => false
    t.integer "image_id",    :null => false
  end

  create_table "donation_comments", :force => true do |t|
    t.integer  "donation_id",                :null => false
    t.string   "comment",     :limit => 500, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", :force => true do |t|
    t.string   "phone",      :limit => 20,                    :null => false
    t.string   "address",    :limit => 20,                    :null => false
    t.string   "email",      :limit => 50,                    :null => false
    t.string   "name",       :limit => 50,                    :null => false
    t.boolean  "track",                    :default => false
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations_images", :id => false, :force => true do |t|
    t.integer "donation_id", :null => false
    t.integer "image_id",    :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "type",                            :null => false
    t.binary   "data",        :limit => 16777215, :null => false
    t.string   "description", :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "donation_id",                              :null => false
    t.integer  "delivery_id",                              :null => false
    t.string   "category",    :limit => 20,                :null => false
    t.integer  "quantity",                                 :null => false
    t.integer  "status",                    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["delivery_id"], :name => "item_delivery_foreign_key"
  add_index "items", ["donation_id"], :name => "item_donation_foreign_key"

  create_table "news", :force => true do |t|
    t.string   "title",      :limit => 200, :null => false
    t.text     "content",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_images", :id => false, :force => true do |t|
    t.integer "news_id",  :null => false
    t.integer "image_id", :null => false
  end

  create_table "receivers", :force => true do |t|
    t.string   "name",         :limit => 50,                     :null => false
    t.text     "introduction",                                   :null => false
    t.string   "address",      :limit => 200
    t.string   "phone",        :limit => 20
    t.string   "email",        :limit => 50
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
