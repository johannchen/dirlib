class AddImageToFamilies < ActiveRecord::Migration
  def self.up
    add_column :families, :image, :string
  end

  def self.down
    remove_column :families, :image
  end
end
