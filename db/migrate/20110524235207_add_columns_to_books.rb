class AddColumnsToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :authors, :string
    add_column :books, :published_date, :date
    add_column :books, :description, :text
    add_column :books, :pages, :integer
    add_column :books, :thumbnail, :string
  end

  def self.down
  end
end
