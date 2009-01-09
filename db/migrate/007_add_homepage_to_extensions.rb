class AddHomepageToExtensions < ActiveRecord::Migration
  def self.up
    add_column :extensions, :homepage, :string
  end

  def self.down
    remove_column :extensions, :homepage
  end
end