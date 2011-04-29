class AddActiveToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :active, :boolean, :default => true
    remove_column :contacts, :photo_file_name
    remove_column :contacts, :photo_content_type
    remove_column :contacts, :photo_fingerprint
    remove_column :contacts, :photo_file_size
    remove_column :contacts, :photo_updated_at
  end

  def self.down
    remove_column :contacts, :active
  end
end
