# Right now this only searches extensions, but it would be great if it could search all objects
# in the system in the future.
class SearchController < ApplicationController
  
  def search
    @query, @page = params[:q], params[:page]
    @extensions = []
    @extensions = Extension.search(@query, @page) if results?
  end
  
  protected
  
    def results?
      !@query.blank?
    end
    helper_method :results?
  
end