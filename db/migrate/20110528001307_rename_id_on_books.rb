class RenameIdOnBooks < ActiveRecord::Migration
  def self.up
    rename_column :books, :owner_id, :user_id
    rename_column :books, :borrower_id, :contact_id
  end

  def self.down
  end
end
