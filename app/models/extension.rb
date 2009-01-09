class Extension < ActiveRecord::Base
  belongs_to :author
  
  validates_presence_of :name
  validates_uniqueness_of :name, :allow_nil => true
  validates_presence_of :repository_url, :if => proc {|e| e.download_url.blank? }, :message => "required unless download URL given"
  validates_presence_of :download_url, :if => proc {|e| e.repository_url.blank? }, :message => "required unless repository URL given"
  validates_uniqueness_of :repository_url, :if => :repository_url?
  validates_uniqueness_of :download_url, :if => :download_url?
  validates_presence_of :author_id
  validates_presence_of :install_type
  validates_presence_of :homepage
  validates_presence_of :current_version
  validates_presence_of :supports_radiant_version
  
  def to_param
    [id, name].join('-').gsub(/[^a-z0-9]+/i, '-').sub(/-$/, '')
  end
end
