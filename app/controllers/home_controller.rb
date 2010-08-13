class HomeController < ApplicationController
  def index
    @extensions = Extension.find(:all, :order => "created_at DESC", :limit => 4)
    @authors = Author.find(:all, :conditions => ["extensions_count > 0"], :order => "RAND()", :limit => 5)
  end
end