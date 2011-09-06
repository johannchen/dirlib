class AddColumnsToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :verses, :text
    add_column :messages, :summary, :text
    add_column :messages, :application, :text
    add_column :messages, :url, :string
    add_column :messages, :user_id, :integer
  end

  def self.down
  end
end
