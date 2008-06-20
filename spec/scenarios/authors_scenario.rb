class AuthorsScenario < Scenario::Base

  def load
    create_model Author, :quentin,
              :login => "quentin",
              :email => "quentin@example.com",
              :password => "test",
              :password_confirmation => "test"

    create_model Author, :aaron,
              :login => "aaron",
              :email => "aaron@example.com",
              :password => "test",
              :password_confirmation => "test"
  end

  helpers do
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