class AuthorsDataset < Dataset::Base

  def load
    create_author "Quentin"
    create_author "Aaron", :notes => "Just another extension author"
    create_author "Jim", :last_name => "Gay", :email => "jim@saturnflyer.com", :notes => "Core team member."
    create_author "John", :last_name => "Long", :login => "jlong", :email => "me@johnwlong.com", :notes => "Creator of Radiant CMS and lead designer. Principle of Wiseheart Design."
    create_author "Sean", :last_name => "Cribbs", :email => "sean.cribbs@gmail.com", :notes => "Lead developer of Radiant CMS."
    create_author "Adam", :notes => "I haven't created any extensions."
  end

  helpers do
    def create_author(first_name, attributes = {})
      symbol = first_name.downcase.intern
      create_model(Author, symbol,
        {
          :first_name => first_name,
          :login => symbol.to_s,
          :email => "#{symbol.to_s}@example.com",
          :password => "test",
          :password_confirmation => "test"
        }.merge(attributes)
      )
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