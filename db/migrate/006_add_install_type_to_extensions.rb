class AddInstallTypeToExtensions < ActiveRecord::Migration
  def self.up
    add_column :extensions, :install_type, :string
  end

  def self.down
    remove_column :extensions, :install_type
  end
end
