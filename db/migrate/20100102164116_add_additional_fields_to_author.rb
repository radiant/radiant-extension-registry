class AddAdditionalFieldsToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :company, :string, :limit => 40
    add_column :authors, :location, :string, :limit => 40
  end

  def self.down
    remove_column :authors, :location
    remove_column :authors, :company
  end
end
