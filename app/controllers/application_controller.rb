# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  include AuthenticatedSystem
  include OpenIdAuthentication
  
  def can_edit?(model)
    case model
    when Extension
      !!(current_author && (current_author.id == model.author_id))
    when Author
      !!(current_author && (current_author.id == model.id))
    else
      raise "unknown model #{model}:#{model.class}"
    end
  end
  helper_method :can_edit?
  
end
