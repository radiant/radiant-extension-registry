class AddAvailableForHireToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :available_for_hire, :boolean, :default => false
  end

  def self.down
    remove_column :authors, :available_for_hire
  end
end
