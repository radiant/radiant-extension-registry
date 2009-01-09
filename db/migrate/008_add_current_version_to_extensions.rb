class AddCurrentVersionToExtensions < ActiveRecord::Migration
  def self.up
    add_column :extensions, :current_version, :string
  end

  def self.down
    remove_column :extensions, :current_version
  end
end
