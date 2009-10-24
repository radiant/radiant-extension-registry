require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead.
# Then, you can remove it from this and the functional test.
include AuthenticatedTestHelper

describe Author do
  dataset :authors

  describe 'being created' do
    before do
      @author = nil
      @creating_author = lambda do
        @author = create_author_via_model
        violated "#{@author.errors.full_messages.to_sentence}" if @author.new_record?
      end
    end
    
    it 'increments Author#count' do
      @creating_author.should change(Author, :count).by(1)
    end
  end

  it 'requires login' do
    lambda do
      u = create_author_via_model(:login => nil)
      u.errors.on(:login).should_not be_nil
    end.should_not change(Author, :count)
  end

  it 'requires password' do
    lambda do
      u = create_author_via_model(:password => nil)
      u.errors.on(:password).should_not be_nil
    end.should_not change(Author, :count)
  end

  it 'requires password confirmation' do
    lambda do
      u = create_author_via_model(:password_confirmation => nil)
      u.errors.on(:password_confirmation).should_not be_nil
    end.should_not change(Author, :count)
  end

  it 'requires email' do
    lambda do
      u = create_author_via_model(:email => nil)
      u.errors.on(:email).should_not be_nil
    end.should_not change(Author, :count)
  end

  it 'resets password' do
    authors(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    Author.authenticate('quentin', 'new password').should == authors(:quentin)
  end

  it 'does not rehash password' do
    authors(:quentin).update_attributes(:login => 'quentin2')
    Author.authenticate('quentin2', 'test').should == authors(:quentin)
  end

  it 'authenticates author' do
    Author.authenticate('quentin', 'test').should == authors(:quentin)
  end

  it 'sets remember token' do
    authors(:quentin).remember_me
    authors(:quentin).remember_token.should_not be_nil
    authors(:quentin).remember_token_expires_at.should_not be_nil
  end

  it 'unsets remember token' do
    authors(:quentin).remember_me
    authors(:quentin).remember_token.should_not be_nil
    authors(:quentin).forget_me
    authors(:quentin).remember_token.should be_nil
  end

  it 'remembers me for one week' do
    one_week = 1.week.from_now.utc
    authors(:quentin).remember_me_for 1.week
    authors(:quentin).remember_token.should_not be_nil
    authors(:quentin).remember_token_expires_at.should_not be_nil
    authors(:quentin).remember_token_expires_at.should be_close(one_week, 1)
  end

  it 'remembers me until one week' do
    time = 1.week.from_now.utc
    authors(:quentin).remember_me_until time
    authors(:quentin).remember_token.should_not be_nil
    authors(:quentin).remember_token_expires_at.should_not be_nil
    authors(:quentin).remember_token_expires_at.should be_close(time, 1)
  end

  it 'remembers me default two weeks' do
    two_weeks = 2.weeks.from_now.utc 
    authors(:quentin).remember_me
    authors(:quentin).remember_token.should_not be_nil
    authors(:quentin).remember_token_expires_at.should_not be_nil
    authors(:quentin).remember_token_expires_at.should be_close(two_weeks, 1)
  end

  it "should render XML without the crypted password, salt, identity_url, or remember_token fields" do
    authors(:quentin).to_xml.should_not match(/crypted-password/)
    authors(:quentin).to_xml.should_not match(/salt/)
    authors(:quentin).to_xml.should_not match(/identity-url/)
    authors(:quentin).to_xml.should_not match(/remember-token/)
  end
  
protected
  def create_author_via_model(options = {})
    record = Author.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
    record.save
    record
  end
end
