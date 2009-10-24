class ExtensionsDataset < Dataset::Base
  uses :authors
  
  def load
    create_extension("page_attachments",
      :repository_url => "git://github.com/seancribbs/radiant-page-attachments.git",
      :download_url => "http://seancribbs.com/download/page_attachments.tar.gz",
      :download_type => "Tarball"
    )
    create_extension("reorder", 
      :repository_url => "git://github.com/seancribbs/radiant-reorder.git",
      :download_url => "http://seancribbs.com/download/reorder.tar.gz",
      :download_type => "Tarball"
    )
    create_extension("gitonly", 
      :repository_url => "git://github.com/seancribbs/radiant-gitonly.git"
    )
    create_extension("taronly", 
      :repository_url => "",
      :download_url => "http://seancribbs.com/download/taronly.tar.gz",
      :repository_type => nil,
      :download_type => "Tarball",
      :author_id => author_id(:aaron)
    )
  end
  
  helpers do
    def create_extension(name, attributes = {})
      create_model Extension, name.intern, extension_params(attributes.symbolize_keys.merge({:name => name}))
    end
    
    def extension_params(attributes = {})
      {
        :name => "test_extension",
        :repository_url => "git://github.com/seancribbs/radiant-test-extension.git",
        :description => "(none)",
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