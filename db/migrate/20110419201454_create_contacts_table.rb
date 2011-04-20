class CreateContactsTable < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :user_id
      t.string :name
      t.string :gender
      t.string :cell_phone
      t.string :work_phone
      t.datetime :birthday
      t.string :email
      t.string :website
      t.string :business_name
      t.string :business_description
      t.string :business_phone
      t.string :business_website
      t.text :about
      t.string :status
      t.string :photo_file_name
      t.string :photo_content_type
      t.string :photo_fingerprint
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
