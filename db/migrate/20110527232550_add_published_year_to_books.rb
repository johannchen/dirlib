class AddPublishedYearToBooks < ActiveRecord::Migration
  def self.up
    remove_column :books, :published_date
    add_column :books, :published_year, :string
  end

  def self.down
    remove_column :books, :published_year
  end
end
