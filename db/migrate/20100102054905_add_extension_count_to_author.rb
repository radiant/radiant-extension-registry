class AddExtensionCountToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :extensions_count, :integer, :default => 0
    Extension.find(:all).each &:update_cached_fields
  end

  def self.down
    remove_column :authors, :extensions_count
  end
end
