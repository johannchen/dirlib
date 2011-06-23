class AddChineseNameToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :other_name, :string
  end

  def self.down
    remove_column :contacts, :other_name
  end
end
