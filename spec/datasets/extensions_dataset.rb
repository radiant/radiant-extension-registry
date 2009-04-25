class ExtensionsDataset < Dataset::Base
  uses :authors
  
  def load
    create_model Extension, :page_attachments, 
      extension_params(:name => "page_attachments", 
          :repository_url => "git://github.com/seancribbs/radiant-page-attachments.git",
          :download_url => "http://seancribbs.com/download/page_attachments.tar.gz",
          :download_type => "Tarball")
    create_model Extension, :reorder,
      extension_params(:name => "reorder", 
        :repository_url => "git://github.com/seancribbs/radiant-reorder.git",
        :download_url => "http://seancribbs.com/download/reorder.tar.gz",
        :download_type => "Tarball")
    create_model Extension, :gitonly,
      extension_params(:name => "gitonly", 
        :repository_url => "git://github.com/seancribbs/radiant-gitonly.git")
    create_model Extension, :taronly,
      extension_params(:name => "taronly", 
        :repository_url => nil,
        :download_url => "http://seancribbs.com/download/taronly.tar.gz",
        :repository_type => nil,
        :download_type => "Tarball")
  end
  
  helpers do
    def extension_params(attributes = {})
      {
        :name => "test_extension",
        :repository_url => "git://github.com/seancribbs/radiant-test-extension.git",
        :download_url => nil,
        :author_id => author_id(:quentin),
        :repository_type => "Git",
        :homepage => "http://github.com/seancribbs/radiant-test-extension",
        :current_version => "1.0.0",
        :supports_radiant_version => "0.7.1"
      }.merge(attributes.symbolize_keys)
    end
  end
end