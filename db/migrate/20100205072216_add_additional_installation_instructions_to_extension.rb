class AddAdditionalInstallationInstructionsToExtension < ActiveRecord::Migration
  def self.up
    add_column :extensions, :additional_installation_instructions, :string, :limit => 1000
  end

  def self.down
    remove_column :extensions, :additional_installation_instructions
  end
end
