require File.dirname(__FILE__) + '/../spec_helper'

describe ExtensionsController do
  dataset :extensions
  
  describe "index action" do
    it "should not require login" do
      controller.should_not_receive(:access_denied)
      get :index
      response.should_not be_redirect
    end
    
    it "should load a list of all extensions" do
      get :index
      assigns[:extensions].should_not be_blank
    end
    
    it "should render the index template" do
      get :index
      response.should render_template('index')
    end
    
    it "should provide XML" do
      get :index, :format => 'xml'
      response.headers['type'].should match(/xml/)
    end
  end
  
  describe "show action" do
    it "should not require login" do
      controller.should_not_receive(:access_denied)
      get :show, :id => extension_id(:page_attachments)
      response.should_not be_redirect
    end
    
    it "should load an extension by id" do
      get :show, :id => extension_id(:page_attachments)
      assigns[:extension].should == extensions(:page_attachments)
    end
    
    it "should render the show template" do
      get :show, :id => extension_id(:page_attachments)
      response.should render_template('show')
    end
    
    it "should should provide XML" do
      get :show, :id => extension_id(:page_attachments), :format => 'xml'
      response.headers['type'].should match(/xml/)
    end
  end
  
  describe "new action" do
    before :each do
      login_as(:quentin)
    end
    
    it "should require login" do
      logout
      get :new
      response.should be_redirect
    end
    
    it "should render the new template" do
      get :new
      response.should render_template('new')
    end
    
    it "should load a new extension" do
      get :new
      assigns[:extension].should_not be_nil
      assigns[:extension].should be_new_record
    end
  end
  
  describe "create action" do
    before :each do
      login_as :quentin
      @extension = extensions(:page_attachments)
      Extension.stub!(:new).and_return(@extension)
    end
    
    it "should require login" do
      logout
      post :create
      Extension.should_not_receive(:new)
      response.should be_redirect
    end

    describe "when save succeeds" do
      before :each do
        @extension.should_receive(:save).and_return(true)
      end
      
      it "should set the author" do
        @extension.should_receive(:author=).with(authors(:quentin))
        post :create
      end
      
      it "should redirect" do
        post :create
        response.should be_redirect
      end
      
      it "should build the extension object" do
        post :create
        assigns[:extension].should == @extension
      end
      
      it "should create the object when XML" do
        put :create, :format => 'xml'
        (200..299).should include(response.response_code)
      end
      
    end
    
    describe "when save fails" do
      before :each do
        @extension.should_receive(:save).and_return(false)
      end
      
      it "should render the new template" do
        post :create
        response.should render_template('new')
      end
      
      it "should render errors when XML" do
        put :create
        response.should_not be_success
      end
    end
    
  end
  
  describe "edit action" do
    before :each do
      login_as :sean
    end
    
    it "should require login" do
      logout
      get :edit, :id => extension_id(:page_attachments)
      response.should be_redirect
    end
    
    it "should require the author to be the owner of the extension" do
      login_as :aaron
      get :edit, :id => extension_id(:page_attachments)
      response.should be_redirect
      flash[:warning].should_not be_nil
    end

    it "should load the given extension" do
      get :edit, :id => extension_id(:page_attachments)
      assigns[:extension].should == extensions(:page_attachments)
    end
    
    it "should render the edit template" do
      get :edit, :id => extension_id(:page_attachments)
      response.should render_template('edit')
    end
  end
  
  describe "update action" do
    before :each do
      login_as :sean
      @extension = extensions(:page_attachments)
    end
    
    it "should require login" do
      logout
      put :update, :id => @extension.id, :extension => { :name => "changed" }
      extensions(:page_attachments).name.should == "page_attachments"
      response.should be_redirect
    end
    
    it "should require the author to be the owner of the extension" do
      login_as :aaron
      put :update, :id => extension_id(:page_attachments), :extension => { :name => "changed" }
      extensions(:page_attachments).name.should == "page_attachments"
      response.should be_redirect
      flash[:warning].should_not be_nil
    end

    describe "when save succeeds" do
      it "should redirect" do
        put :update, :id => extension_id(:page_attachments), :extension => { :name => "changed" }
        extensions(:page_attachments).name.should == "changed"
        response.should be_redirect
      end
      
      it "should build the extension object" do
        put :update, :id => extension_id(:page_attachments), :extension => { :name => "changed" }
        extensions(:page_attachments).name.should  == "changed"
        assigns[:extension].should == @extension
      end
      
      it "should update the object when XML" do
        put :update, :id => extension_id(:page_attachments), :extension => { :name => "changed" }, :format => 'xml'
        extensions(:page_attachments).name.should == "changed"
        (200..299).should include(response.response_code)
      end
    end
    
    describe "when save fails" do
      it "should render the edit template" do
        put :update, :id => extension_id(:page_attachments), :extension => { :name => "" }
        response.should render_template('edit')
        extensions(:page_attachments).name.should == "page_attachments"
      end
      
      it "should render errors when XML" do
        put :update, :id => extension_id(:page_attachments), :extension => { :name => "" }, :format => 'xml'
        response.should_not be_success
        extensions(:page_attachments).name.should == "page_attachments"
      end
    end
  end
  
  describe "destroy action" do
    before :each do
      login_as :sean
      @extension = extensions(:page_attachments)
    end
    
    it "should require login" do
      logout
      delete :destroy, :id => @extension.id
      Extension.find_by_id(@extension.id).should_not be_nil
      response.should be_redirect
    end
    
    it "should require the author to be the owner of the extension" do
      login_as :aaron
      delete :destroy, :id => @extension.id
      Extension.find_by_id(@extension.id).should_not be_nil
      response.should be_redirect
      flash[:warning].should_not be_nil
    end
    
    it "should destroy and redirect" do
      delete :destroy, :id => @extension.id
      Extension.find_by_id(@extension.id).should be_nil
      response.should be_redirect
    end
    
    it "should destroy when XML" do
      delete :destroy, :id => @extension.id, :format => 'xml'
      Extension.find_by_id(@extension.id).should be_nil
      (200..299).should include(response.response_code)
    end
  end
end
