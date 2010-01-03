# This controller handles the login/logout function of the site.
class SessionsController < ApplicationController
  
  # render new.rhtml
  def new
  end
  
  def create
    if using_open_id?(params[:identity_url])
      open_id_authentication
    else
      password_authentication(params[:login], params[:password])
    end
  end
  
  def destroy
    self.current_author.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You are now logged out."
    redirect_back_or_default(new_session_url)
  end
  
  protected
  
    def password_authentication(login, password)
      self.current_author = Author.authenticate(login, password)
      if logged_in?
        successful_login
      else
        failed_login "Invalid username or password."
      end
    end
    
    def open_id_authentication
      authenticate_with_open_id do |result, identity_url|
        if result.successful?
          if self.current_author = Author.find_or_create_by_identity_url(identity_url)
            successful_login
          else
            failed_login "Sorry, no author by that identity URL exists (#{identity_url})"
          end
        else
          failed_login result.message
        end
      end
    end
  
  private
  
    def successful_login
      if params[:remember_me] == "1"
        current_author.remember_me unless current_author.remember_token?
        cookies[:auth_token] = { :value => self.current_author.remember_token , :expires => self.current_author.remember_token_expires_at }
      end
      redirect_back_or_default '/'
      flash[:notice] = 'You are now logged in.'
    end
    
    def failed_login(message)
      redirect_to new_session_path
      flash[:error] = message
    end
  
end
