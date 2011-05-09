class RemoveSomeStatusFromContacts < ActiveRecord::Migration
  def self.up
    remove_column :contacts, :status
    remove_column :contacts, :newcomer
    remove_column :contacts, :staff
    remove_column :contacts, :elder
    remove_column :contacts, :deacon
  end

  def self.down
  end
end
