class SplitInstallTypeIntoRepoAndDownloadTypes < ActiveRecord::Migration
  REPOSITORY_TYPES = [
    'Git',
    'Subversion'
  ]
  DOWNLOAD_TYPES = [
    'Gem',
    'Tarball',
    'Gzip',
    'Bzip2',
    'Zip'
  ]
  
  def self.up
    add_column :extensions, :repository_type, :string
    add_column :extensions, :download_type, :string
    Extension.reset_column_information
    Extension.find(:all).each do |extension|
      if REPOSITORY_TYPES.include?(extension.install_type)
        extension.repository_type = extension.install_type
      else
        extension.download_type = extension.install_type
      end
    end
    remove_column :extensions, :install_type
  end

  def self.down
    add_column :extensions, :install_type, :string
    Extension.reset_column_information
    Extension.find(:all).each do |extension|
      extension.install_type = extension.repository_type || extension.download_type
    end
    remove_column :extensions, :download_type
    remove_column :extensions, :repository_type
  end
end
