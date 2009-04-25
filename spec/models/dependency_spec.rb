require File.dirname(__FILE__) + '/../spec_helper'

describe Dependency do
  dataset :extensions
  
  before(:each) do
    @dependency = Dependency.new(:extension_id => extension_id(:page_attachments), :satisfier_id => extension_id(:reorder))
  end

  it "should not allow simple circular dependencies" do
    @dependency.extension_id = @dependency.satisfier_id = extensions(:page_attachments)
    @dependency.should_not be_valid
    @dependency.should have(1).error_on(:base)
  end
  
  it "should require an extension" do
    @dependency.extension_id = nil
    @dependency.should_not be_valid
    @dependency.should have(1).error_on(:extension_id)
  end

  it "should require a satisfier" do
    @dependency.satisfier_id = nil
    @dependency.should_not be_valid
    @dependency.should have(1).error_on(:satisfier_id)
  end
  
end
