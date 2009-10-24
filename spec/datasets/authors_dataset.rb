class AuthorsDataset < Dataset::Base

  def load
    create_author "Quentin"
    create_author "Aaron"
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