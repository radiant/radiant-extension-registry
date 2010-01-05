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
      :description => "Allows reordering of child pages within their parent page.",
      :download_type => "Tarball",
      :download_url => "http://seancribbs.com/download/reorder.tar.gz",
      :repository_url => "git://github.com/seancribbs/radiant-reorder.git"
    )
    create_extension("gitonly",
      :description => "This extension is only available via Git. A regular download is not available.\n\nThere is really not a lot left to say. This is dummy text.",
      :repository_url => "git://github.com/seancribbs/radiant-gitonly-extension.git"
    )
    create_extension("taronly", 
      :author_id => author_id(:aaron),
      :description => "This extension is only available as a Tarball Git. It cannot be downloaded via Git.\n\nThere is really not a lot left to say. This is dummy text.",
      :download_type => "Tarball",
      :download_url => "http://seancribbs.com/download/taronly.tar.gz",
      :repository_type => nil,
      :repository_url => nil
    )
    create_extension("bespin_editor",
      :author_id => author_id(:john),
      :description => "Bespin is an embeddable source code editor from Mozilla that provides robust syntax highlighting, indentation support, and other features.\n\nThe Bespin Editor Extension replaces all textareas in Radiant with the Bespin editor. Note that Bespin only works in Web browsers that support the HTML canvas tag (Safari, Firefox, and Opera)."
    )
    create_extension("help",
      :author_id => author_id(:jim),
      :description => "Provides Help documentation in a tab in the Radiant interface and provides a way for developers to easily include their own help information."
    )
  end
  
  helpers do
    def create_extension(name, attributes = {})
      create_model Extension, name.intern, extension_params(attributes.symbolize_keys.merge({:name => name}))
    end
    
    def extension_params(attributes = {})
      name = attributes[:name] || "test"
      slug = name.downcase.gsub(" ", "-")
      author = Author.find(attributes[:author_id] || author_id(:quentin))
      {
        :name => name,
        :description => "(none)",
        :download_url => nil,
        :author_id => author.id,
        :repository_type => "Git",
        :repository_url => "git://github.com/#{author.login}/radiant-#{slug}-extension.git",
        :homepage => "http://github.com/#{author.login}/radiant-#{slug}-extension",
        :current_version => "1.0.0",
        :supports_radiant_version => "0.7.1"
      }.merge(attributes.symbolize_keys)
    end
  end
end