class RemoveBirthdayFromContacts < ActiveRecord::Migration
  def self.up
    remove_column :contacts, :birthday
    add_column :contacts, :birthday, :date
  end

  def self.down
  end
end
