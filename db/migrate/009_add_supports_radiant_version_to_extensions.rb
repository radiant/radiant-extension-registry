class AddSupportsRadiantVersionToExtensions < ActiveRecord::Migration
  def self.up
    add_column :extensions, :supports_radiant_version, :string
  end

  def self.down
    remove_column :extensions, :supports_radiant_version
  end
end
