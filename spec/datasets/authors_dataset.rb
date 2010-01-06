class AuthorsDataset < Dataset::Base

  def load
    create_author "Quentin", :last_name => "Randolf", :identity_url => "http://radiant.openid.com"
    create_author "Aaron", :last_name => "Warhaul", :notes => "Just another extension author"
    create_author "Jim", :last_name => "Gay", :login => "saturnflyer", :email => "jim@saturnflyer.com", :notes => "Core team member."
    create_author "John", :last_name => "Long", :login => "jlong", :email => "me@johnwlong.com", :notes => "Creator of Radiant CMS and lead designer. Principle of Wiseheart Design.", :available_for_hire => true
    create_author "Sean", :last_name => "Cribbs", :login => "seancribbs", :email => "seancribbs@gmail.com", :notes => "Lead developer of Radiant CMS.", :available_for_hire => true
    create_author "Adam", :notes => "I haven't created any extensions.", :available_for_hire => false
  end

  helpers do
    def create_author(first_name, attributes = {})
      symbol = first_name.downcase.gsub(" ", "_").intern
      create_model(Author, symbol, author_params(first_name, attributes))
    end
    
    def author_params(first_name, attributes = {})
      login = attributes[:login] || first_name.downcase.gsub(" ", "_")
      {
        :first_name => first_name,
        :login => login,
        :location => ["Chapel Hill, NC", "Cary, NC", "Apex, NC", "Raliegh, NC", "Atlanta, GA", "New York, NY", "San Francisco, CA", "Dallas, TX", "Richmond, VA", "Cleveland, OH", "Chicago, IL", "Naperville, IL", "Auburn, AL", "Franktown, VA", "Moscow, Russia", "Sidney, Australia", "Tokyo, Japan"].rand,
        :email => "#{login}@example.com",
        :password => "test",
        :password_confirmation => "test",
        :available_for_hire => [true, false].rand
      }.merge(attributes.symbolize_keys)
    end
    
    def login_as(author = nil)
      session[:author_id] = case author
      when Symbol
        author_id(author)
      when Fixnum, String
        author
      when Author
        author.id
      else
        raise ArgumentError, "login_as requires a symbol, id, or author object"
      end
    end
    
    def logout
      session[:author_id] = nil
    end
  end
end