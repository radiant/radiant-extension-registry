class AddManagerToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :manager, :boolean, :default => false
  end

  def self.down
    remove_column :authors, :manager
  end
end
