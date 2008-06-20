require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe AuthorsController do
  scenario :authors
  
  it 'allows signup' do
    lambda do
      create_author
      response.should be_redirect
    end.should change(Author, :count).by(1)
  end

  it 'requires login on signup' do
    lambda do
      create_author(:login => nil)
      assigns[:author].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Author, :count)
  end

  it 'requires password on signup' do
    lambda do
      create_author(:password => nil)
      assigns[:author].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Author, :count)
  end

  it 'requires password confirmation on signup' do
    lambda do
      create_author(:password_confirmation => nil)
      assigns[:author].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Author, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_author(:email => nil)
      assigns[:author].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Author, :count)
  end

  def create_author(options = {})
    post :create, :author => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end