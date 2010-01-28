class Author < ActiveRecord::Base; end

class CombineNameFields < ActiveRecord::Migration
  def self.up
    add_column :authors, :name, :string
    authors = Author.find(:all)
    authors.each do |author|
      author.name = [author.first_name, author.last_name].join(" ")
      author.save!
    end
    remove_column :authors, :first_name
    remove_column :authors, :last_name
  end
  
  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
