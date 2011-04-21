class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :contact_id
      t.string :relationship

      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
