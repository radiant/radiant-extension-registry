require File.dirname(__FILE__) + '/../spec_helper'

describe Extension do
  dataset :extensions
  
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
    @extension.download_type = "Tarball"
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
    @extension.to_param.should match(/^\d+-test$/)
  end
  
  it "should require an author" do
    @extension.author_id = nil
    @extension.should_not be_valid
    @extension.should have(1).error_on(:author_id)
  end
  
  it "should require the download type when a download url is provided" do
    @extension = extensions(:taronly)
    @extension.download_type = nil
    @extension.download_url.should_not be_nil
    @extension.should_not be_valid
    @extension.should have(1).error_on(:download_type)
  end
  
  it "should require the repository type when a repository url is provided" do
    @extension = extensions(:gitonly)
    @extension.repository_type = nil
    @extension.repository_url.should_not be_nil
    @extension.should_not be_valid
    @extension.should have(1).error_on(:repository_type)
  end
  
  it "should provide install type for backward-compatibility" do
    @extension = extensions(:page_attachments)
    @extension.install_type.should == @extension.repository_type
    
    @extension = extensions(:taronly)
    @extension.install_type.should == @extension.download_type
    
    @extension = extensions(:gitonly)
    @extension.install_type.should == @extension.repository_type
  end
  
  it "should update the extension count on author when a new one is created" do
    @author = authors(:sean)
    count = @author.extensions_count
    3.times { |i| Extension.create!(extension_params(:name => i.to_s, :author_id => author_id(:sean))) }
    @author.reload
    @author.extensions_count.should == count + 3
  end
  
  it "should decrement the extension count on author when an extension is deleted" do
    @author = authors(:sean)
    count = @author.extensions_count
    @author.extensions.last.destroy
    @author.reload
    @author.extensions_count.should == (count - 1)
  end
end
