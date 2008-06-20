module AuthenticatedTestHelper
  # Sets the current author in the session from the author fixtures.
  def login_as(author)
    @request.session[:author_id] = author ? authors(author).id : nil
  end

  def authorize_as(user)
    @request.env["HTTP_AUTHORIZATION"] = user ? ActionController::HttpAuthentication::Basic.encode_credentials(users(user).login, 'test') : nil
  end
end
