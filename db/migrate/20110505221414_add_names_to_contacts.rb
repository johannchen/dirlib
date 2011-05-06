class AddNamesToContacts < ActiveRecord::Migration
  def self.up
    rename_column :contacts, :name, :first_name
    rename_column :users, :name, :first_name
    add_column :contacts, :last_name, :string
    add_column :users, :last_name, :string
  end

  def self.down
    remove_column :contacts, :last_name
    remove_column :users, :last_name
  end
end
