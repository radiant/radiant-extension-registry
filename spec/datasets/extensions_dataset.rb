class ExtensionsDataset < Dataset::Base
  uses :authors
  
  def load
    create_extension("page_attachments",
      :author_id => author_id(:sean),
      :description => "Supports uploaded files as “attachments” to pages.",
      :download_type => "Tarball",
      :download_url => "http://seancribbs.com/download/page_attachments.tar.gz",
      :repository_url => "git://github.com/seancribbs/radiant-page-attachments.git"
    )
    create_extension("reorder", 
      :download_type => "Tarball",
      :download_url => "http://seancribbs.com/download/reorder.tar.gz",
      :repository_url => "git://github.com/seancribbs/radiant-reorder.git"
    )
    create_extension("gitonly",
      :repository_url => "git://github.com/seancribbs/radiant-gitonly.git"
    )
    create_extension("taronly", 
      :author_id => author_id(:aaron),
      :download_type => "Tarball",
      :download_url => "http://seancribbs.com/download/taronly.tar.gz",
      :repository_type => nil,
      :repository_url => ""
    )
    create_extension("bespin_editor",
      :author_id => author_id(:john),
      :description => "Bespin is an embeddable source code editor from Mozilla that provides robust syntax highlighting, indentation support, and other features.\n\nThe Bespin Editor Extension replaces all textareas in Radiant with the Bespin editor. Note that Bespin only works in Web browsers that support the HTML canvas tag (Safari, Firefox, and Opera).",
      :repository_url => "git://github.com/jlong/radiant-bespin-editor-extension.git"
    )
    create_extension("help",
      :author_id => author_id(:jim),
      :homepage => "http://github.com/saturnflyer/radiant-help-extension/",
      :repository_url => "git://github.com/saturnflyer/radiant-help-extension.git",
      :description => "Provides Help documentation in a tab in the Radiant interface and provides a way for developers to easily include their own help information."
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