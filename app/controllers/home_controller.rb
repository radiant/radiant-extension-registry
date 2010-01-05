class HomeController < ApplicationController
  def index
    @extensions = Extension.find(:all, :order => "created_at DESC", :limit => 5)
    @authors = Author.find(:all, :conditions => ["extensions_count > 0"], :order => "RANDOM()", :limit => 5)
  end
end