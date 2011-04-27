class AddColumnsToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :address_line_1, :string
    add_column :contacts, :address_line_2, :string
    add_column :contacts, :city, :string
    add_column :contacts, :state, :string
    add_column :contacts, :zip, :string
    add_column :contacts, :newcomer, :boolean, :default => false
    add_column :contacts, :member, :boolean, :default => false
    add_column :contacts, :staff, :boolean, :default => false
    add_column :contacts, :elder, :boolean, :default => false
    add_column :contacts, :deacon, :boolean, :default => false
  end

  def self.down
  end
end
