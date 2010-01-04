class HomeController < ApplicationController
  def index
    @extensions = Extension.find(:all, :order => "created_at DESC", :limit => 7)
    @authors = Author.find(:all, :order => "created_at DESC", :limit => 5)
  end
end