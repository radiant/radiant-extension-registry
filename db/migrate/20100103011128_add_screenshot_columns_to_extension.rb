class AddScreenshotColumnsToExtension < ActiveRecord::Migration
  def self.up
    add_column :extensions, :screenshot_file_name,    :string
    add_column :extensions, :screenshot_content_type, :string
    add_column :extensions, :screenshot_file_size,    :integer
    add_column :extensions, :screenshot_updated_at,   :datetime
  end

  def self.down
    remove_column :extensions, :screenshot_file_name
    remove_column :extensions, :screenshot_content_type
    remove_column :extensions, :screenshot_file_size
    remove_column :extensions, :screenshot_updated_at
  end
end
