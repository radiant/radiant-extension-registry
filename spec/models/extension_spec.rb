require File.dirname(__FILE__) + '/../spec_helper'

describe Extension do
  scenario :extensions
  
  before(:each) do
    @extension = Extension.new(extension_params)
  end

  it "should require a name" do
    @extension.name = nil
    @extension.should_not be_valid
    @extension.should have(1).error_on(:name)
  end

  it "should require a unique name" do
    @extension.name = extensions(:page_attachments).name
    @extension.should_not be_valid
    @extension.should have(1).error_on(:name)
  end
  
  it "should require a repository url or download url" do
    @extension.download_url = nil
    @extension.repository_url = nil
    @extension.should_not be_valid
    @extension.should have(1).error_on(:repository_url)
    @extension.should have(1).error_on(:download_url)
  end
  
  it "should not require a download url if repository url is present" do
    @extension.repository_url.should_not be_nil
    @extension.should be_valid
  end
  
  it "should not require a repository url if a download url is present" do
    @extension.repository_url = nil
    @extension.download_url = "http://seancribbs.com/download/test_extension.tar.gz"
    @extension.should be_valid
  end
  
  it "should require the repository url to be unique if present" do
    @extension.repository_url = extensions(:page_attachments).repository_url
    @extension.should_not be_valid
  end
  
  it "should require the download url to be unique if present" do
    @extension.download_url = extensions(:page_attachments).download_url
    @extension.should_not be_valid
  end
  
  it "should be valid" do
    @extension.should be_valid
  end
  
  it "should have a friendly URL parameter" do
    @extension.save
    @extension.to_param.should match(/^\d+-test-extension$/)
  end
  
  it "should require an author" do
    @extension.author_id = nil
    @extension.should_not be_valid
    @extension.should have(1).error_on(:author_id)
  end
  
  it "should require the installation type" do
    @extension.install_type = nil
    @extension.should_not be_valid
    @extension.should have(1).error_on(:install_type)
  end
end
