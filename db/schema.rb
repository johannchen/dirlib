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

ActiveRecord::Schema.define(:version => 20110528001307) do

  create_table "books", :force => true do |t|
    t.string   "google_book_id"
    t.string   "title"
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authors"
    t.text     "description"
    t.integer  "pages"
    t.string   "thumbnail"
    t.boolean  "lost"
    t.date     "borrowed_date"
    t.boolean  "available"
    t.string   "published_year"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_groups", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_statuses", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.string   "gender"
    t.string   "cell_phone"
    t.string   "work_phone"
    t.string   "email"
    t.string   "website"
    t.string   "business_name"
    t.string   "business_description"
    t.string   "business_phone"
    t.string   "business_website"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "member",               :default => false
    t.boolean  "active",               :default => true
    t.integer  "family_id"
    t.string   "home_phone"
    t.date     "attend_since"
    t.date     "birthday"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "families", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "category_id"
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

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "first_name"
    t.string   "last_name"
  end

end
