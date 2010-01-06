require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do
  dataset :authors
  
  it 'logins and redirects' do
    post :create, :login => 'quentin', :password => 'test'
    session[:author_id].should_not be_nil
    response.should be_redirect
  end
  
  it 'fails login and redirects' do
    post :create, :login => 'quentin', :password => 'bad password'
    session[:author_id].should be_nil
    response.should be_redirect
    response.should redirect_to(new_session_path)
  end
  
  describe "OpenID login" do
    before :each do
      @result = mock('OpenID Result')
      controller.should_receive(:authenticate_with_open_id).and_yield(@result, 'http://radiant.openid.com')
    end
    it "logs in and redirects" do
      @result.should_receive(:successful?).and_return(true)
      post :create, :identity_url => "http://radiant.openid.com"
      response.should be_redirect
      response.should redirect_to(author_url(author_id(:quentin)))
    end
    
    it "fails login and redirects" do
      @result.should_receive(:successful?).and_return(false)
      @result.should_receive(:message).and_return("Login failed")
      post :create, :identity_url => "http://radiant.openid.com"
      response.should be_redirect
      response.should redirect_to(new_session_path)
    end
  end
  
  it 'logs out' do
    login_as :quentin
    get :destroy
    session[:author_id].should be_nil
    response.should be_redirect
  end
  
  it 'remembers me' do
    post :create, :login => 'quentin', :password => 'test', :remember_me => "1"
    cookies["auth_token"].should_not be_nil
  end
  
  it 'does not remember me' do
    post :create, :login => 'quentin', :password => 'test', :remember_me => "0"
    cookies["auth_token"].should be_nil
  end
  
  it 'deletes token on logout' do
    login_as :quentin
    get :destroy
    cookies["auth_token"].should be_nil
  end
  
  it 'logs in with cookie' do
    authors(:quentin).remember_me
    request.cookies["auth_token"] = cookie_for(:quentin)
    get :new
    controller.send(:logged_in?).should be_true
  end
  
  it 'fails expired cookie login' do
    authors(:quentin).remember_me
    authors(:quentin).update_attribute :remember_token_expires_at, 5.minutes.ago
    request.cookies["auth_token"] = cookie_for(:quentin)
    get :new
    controller.send(:logged_in?).should_not be_true
  end
  
  it 'fails cookie login' do
    authors(:quentin).remember_me
    request.cookies["auth_token"] = auth_token('invalid_auth_token')
    get :new
    controller.send(:logged_in?).should_not be_true
  end
  
  def auth_token(token)
    CGI::Cookie.new('name' => 'auth_token', 'value' => token)
  end
  
  def cookie_for(author)
    auth_token authors(author).remember_token
  end
end
