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

ActiveRecord::Schema.define(:version => 20110420234431) do

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "gender"
    t.string   "cell_phone"
    t.string   "work_phone"
    t.datetime "birthday"
    t.string   "email"
    t.string   "website"
    t.string   "business_name"
    t.string   "business_description"
    t.string   "business_phone"
    t.string   "business_website"
    t.text     "about"
    t.string   "status"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.string   "photo_fingerprint"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.string   "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

end
