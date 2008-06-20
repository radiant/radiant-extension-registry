class ExtensionsScenario < Scenario::Base
  uses :authors
  
  def load
    create_model Extension, :page_attachments, 
      extension_params(:name => "page_attachments", 
          :repository_url => "git://github.com/seancribbs/radiant-page-attachments.git",
          :download_url => "http://seancribbs.com/download/page_attachments.tar.gz")
    create_model Extension, :reorder,
      extension_params(:name => "reorder", 
        :repository_url => "git://github.com/seancribbs/radiant-reorder.git",
        :download_url => "http://seancribbs.com/download/reorder.tar.gz")
  end
  
  helpers do
    def extension_params(attributes = {})
      {
        :name => "test_extension",
        :repository_url => "git://github.com/seancribbs/radiant-test-extension.git",
        :download_url => nil,
        :author_id => author_id(:quentin)
      }.merge(attributes.symbolize_keys)
    end
  end
end