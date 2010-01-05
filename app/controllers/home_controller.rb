class HomeController < ApplicationController
  def index
    @extensions = Extension.find(:all, :order => "created_at DESC", :limit => 6)
    @authors = Author.find(:all, :order => "RANDOM()", :limit => 5)
  end
end