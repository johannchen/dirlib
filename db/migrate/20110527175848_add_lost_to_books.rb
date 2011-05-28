class AddLostToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :lost, :boolean
    add_column :books, :borrowed_date, :date
    add_column :books, :available, :boolean
  end

  def self.down
    remove_column :books, :lost
    remove_column :books, :borrowed_date
    remove_column :books, :available
  end
end
