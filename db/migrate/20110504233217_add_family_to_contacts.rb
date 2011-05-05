class AddFamilyToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :family_id, :integer
    add_column :contacts, :home_phone, :string
    add_column :contacts, :attend_since, :date
  end

  def self.down
    remove_column :contacts, :family_id
    remove_column :contacts, :home_phone
    remove_column :contacts, :attend_since
  end
end
