class Addinstallationsteps < ActiveRecord::Migration
  def self.up
    add_column :extensions, :installation_steps, :string, :limit => 1000
  end

  def self.down
    remove_column :extensions, :installation_steps
  end
end
