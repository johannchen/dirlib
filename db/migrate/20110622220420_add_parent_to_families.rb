class AddParentToFamilies < ActiveRecord::Migration
  def self.up
    add_column :families, :dad, :integer
    add_column :families, :mom, :integer
  end

  def self.down
    remove_column :families, :dad
    remove_column :families, :mom 
  end
end
