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

end