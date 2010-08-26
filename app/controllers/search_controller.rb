# Right now this only searches extensions, but it would be great if it could search all objects
# in the system in the future.
class SearchController < ApplicationController

  FACET_ORDER= [
    [:supports_radiant_version, "Supported version"],
    [:author_name, "Author"],
    [:repository_type, "Repository type"],
    [:download_type, "Download type"]
  ]
  
  def search
    @query, @page = params[:q], params[:page]
    @facets, @extensions = {}, []
    @headline = ""
    unless @query.blank?
      scope = Extension.best_first
      scope = scope.by_radiant_version(params[:supports_radiant_version]) if params[:supports_radiant_version]
      scope = scope.by_repository_type(params[:repository_type])          if params[:repository_type]
      scope = scope.by_download_type(params[:download_type])              if params[:download_type]
      scope = scope.by_author_name(params[:author_name])                  if params[:author_name]
      @facets = Extension.facets @query, scope.options
      @extensions = scope.search @query, :match_mode=>:extended, :page=>@page, :per_page=>Extension.per_page, :include=>:author
    end
  end
  
  protected
  
    def facet_order
      FACET_ORDER
    end
    helper_method :facet_order
  
    def results?
      !@query.blank? && @extensions.size>0
    end
    helper_method :results?
  
end