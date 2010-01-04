class SearchIndexes < ActiveRecord::Migration
  def self.up
    add_index "extensions", ["name", "description"], :name => "extensions_search", :unique => true
  end

  def self.down
    remove_index "extensions", :name => "extensions_search"
  end
end
