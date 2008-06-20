class CreateExtensions < ActiveRecord::Migration
  def self.up
    create_table :extensions do |t|
      t.string :name
      t.string :repository_url
      t.string :download_url
      t.integer :author_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :extensions
  end
end
