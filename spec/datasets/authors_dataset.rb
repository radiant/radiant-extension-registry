class AuthorsDataset < Dataset::Base

  def load
    create_author "Quentin Randolf", :login => "quentin", :identity_url => "http://radiant.openid.com"
    create_author "Aaron Warhaul", :login => "aaron", :notes => "Just another extension author"
    create_author "Jim Gay", :login => "saturnflyer", :email => "jim@saturnflyer.com", :notes => "Core team member."
    create_author "John Long", :login => "jlong", :email => "me@johnwlong.com", :notes => "Creator of Radiant CMS and lead designer. Principle of Wiseheart Design.", :available_for_hire => true
    create_author "Sean Cribbs", :login => "seancribbs", :email => "seancribbs@gmail.com", :notes => "Lead developer of Radiant CMS.", :available_for_hire => true
    create_author "Adam", :login => "adam", :notes => "I haven't created any extensions.", :available_for_hire => false
  end

  helpers do
    def create_author(name, attributes = {})
      symbol = attributes[:login].to_s
      symbol = name.downcase.gsub(" ", "_") if symbol.blank?
      symbol = symbol.intern
      create_model(Author, symbol, author_params(name, attributes))
    end
    
    def author_params(name, attributes = {})
      login = attributes[:login] || name.downcase.gsub(" ", "_")
      {
        :name => name,
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