class Extension < ActiveRecord::Base
  belongs_to :author
  
  has_attached_file :screenshot, :styles => { :thumb => "120x88>", :medium => "180x133>", :large => "640x480>" }
  
  validates_presence_of :name
  validates_uniqueness_of :name, :allow_nil => true
  validates_presence_of :repository_url, :if => proc {|e| e.download_url.blank? }, :message => "required unless download URL given"
  validates_presence_of :download_url, :if => proc {|e| e.repository_url.blank? }, :message => "required unless repository URL given"
  validates_uniqueness_of :repository_url, :if => :repository_url?
  validates_uniqueness_of :download_url, :if => :download_url?
  validates_presence_of :author_id
  validates_presence_of :repository_type, :if => :repository_url?
  validates_presence_of :download_type, :if => :download_url?
  validates_presence_of :homepage
  validates_presence_of :current_version
  validates_presence_of :supports_radiant_version
  
  after_create  :update_cached_fields
  after_destroy :update_cached_fields
  
  define_index do
    indexes :name
    indexes :description
    indexes author.name, :as=>:author_name, :facet=>true
    indexes author.company, :as=>:author_company

    has :supports_radiant_version, :facet=>true
    has :repository_type, :facet=>true
    has :download_type, :facet=>true
    has 'CRC32(supports_radiant_version)', :as=>:f_supports_radiant_version, :type=>:integer
    has 'CRC32(repository_type)', :as=>:f_repository_type, :type=>:integer
    has 'CRC32(download_type)', :as=>:f_download_type, :type=>:integer
    has :created_at, :updated_at
    
    set_property :field_weights => {
      :name => 3
    }
  end
  
  sphinx_scope(:best_first) { 
    {:order => '@relevance DESC, updated_at DESC'}
  }

  sphinx_scope(:by_author_name) { |name|
    {:conditions => {:author_name => name}}
  }

  sphinx_scope(:by_radiant_version) { |version|
    {:with => {:f_supports_radiant_version => version.to_crc32}}
  }

  sphinx_scope(:by_repository_type) { |type|
    {:with => {:f_repository_type => type.to_crc32}}
  }

  sphinx_scope(:by_download_type) { |type|
    {:with => {:f_download_type => type.to_crc32}}
  }

  def self.per_page
    25
  end
  
  def install_type
    unless repository_type.blank?
      repository_type
    else
      download_type
    end
  end
  
  def to_param
    [id, name].join('-').strip.gsub(/[^a-z0-9]+/i, '-').downcase
  end
  
  def to_xml(options = {})
    options[:indent] ||= 2
    xml = options[:builder] ||= Builder::XmlMarkup.new(:indent => options[:indent])
    xml.instruct! unless options[:skip_instruct]
    
    xml.extension do
      xml.tag!("name", name)
      xml.tag!("description", description)
      xml.tag!("repository-type", repository_type)
      xml.tag!("repository-url", repository_url)
      xml.tag!("download-type", download_type)
      xml.tag!("download-url", download_url)
      xml.tag!("install-type", install_type)
      xml.tag!("supports-radiant-version", supports_radiant_version)
      xml.tag!("author") do
        xml.tag!("name", author.name)
        
        # Depricated
        first_name, last_name = author.name.to_s.split(" ", 2)
        xml.tag!("first-name", first_name)
        xml.tag!("last-name", last_name)
        
        xml.tag!("email", author.email)
      end
    end
  end
  
  protected
    
    def update_cached_fields
      Author.update_all(['extensions_count = ?', Extension.count(:id, :conditions => { :author_id => author_id })], ["id = ?", author_id])
    end
  
end
