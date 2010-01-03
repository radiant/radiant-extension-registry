require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe AuthorsController do
  dataset :authors, :extensions
  
  integrate_views
  
  it 'allows signup' do
    lambda do
      create_author_via_post
      response.should be_redirect
    end.should change(Author, :count).by(1)
  end

  it 'requires login on signup' do
    lambda do
      create_author_via_post(:login => nil)
      assigns[:author].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Author, :count)
  end

  it 'requires password on signup' do
    lambda do
      create_author_via_post(:password => nil)
      assigns[:author].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Author, :count)
  end

  it 'requires password confirmation on signup' do
    lambda do
      create_author_via_post(:password_confirmation => nil)
      assigns[:author].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Author, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_author_via_post(:email => nil)
      assigns[:author].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Author, :count)
  end

  it "should show author details" do
    get :show, :id => author_id(:quentin)
    assigns[:author].should == authors(:quentin)
    response.should be_success
    response.should render_template('show')
  end
  
  it "should render an author as XML" do
    get :show, :id => author_id(:quentin), :format => 'xml'
    assigns[:author].should == authors(:quentin)
    response.should be_success
    response.body.should == authors(:quentin).to_xml
  end
  
  it "should allow editing of logged-in author's profile" do
    login_as(:quentin)
    get :edit, :id => author_id(:quentin)
    response.should be_success
    assigns[:author].should == authors(:quentin)
    response.should render_template('edit')
  end
  
  it "should deny editing of other's profiles" do
    login_as(:quentin)
    get :edit, :id => author_id(:aaron)
    response.should be_redirect
  end
  
  it "should deny editing of profiles when logged out" do
    get :edit, :id => author_id(:quentin)
    response.should be_redirect
  end
  
  describe "index action" do
    it "should render the index template" do
      get :index
      response.should render_template('index')
    end
    
    it "should publish XML" do
      get :index, :format => 'xml'
      response.headers['Content-Type'].should match(/xml/)
    end
    
    it "should load a list of authors" do
      get :index
      assigns[:authors].should_not be_blank
    end
  end

  def create_author_via_post(options = {})
    post :create, :author => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end