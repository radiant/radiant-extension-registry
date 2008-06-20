class AddDescriptionToExtensions < ActiveRecord::Migration
  def self.up
    add_column :extensions, :description, :string, :limit => 1000
  end

  def self.down
    remove_column :extensions, :description
  end
end
