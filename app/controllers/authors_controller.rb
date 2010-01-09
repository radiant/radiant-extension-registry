class AuthorsController < ApplicationController
  before_filter :login_required, :only => [:edit, :update]
  before_filter :can_only_edit_self, :only => [:edit, :update]

  def index
    @authors = Author.paginate :page => params[:page], :conditions => ["extensions_count > 0"], :order => 'last_name, first_name, login'
  end
  
  def show
    @author = Author.find(params[:id])
  end
  
  def new
  end
  
  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @author = Author.new(params[:author])
    @author.save
    if @author.errors.empty?
      self.current_author = @author
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end
  
  def edit
    @author = Author.find(params[:id])
  end
  
  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      flash[:notice] = "Profile updated."
      redirect_to author_path(@author)
    else
      flash[:notice] = "There were errors saving the form."
      render :action => "edit", :status => :unprocessible_entity
    end
  end
  
  protected
  
    def can_only_edit_self
      unless logged_in? && current_author.id.to_i == params[:id].to_i
        flash[:error] = "You cannot edit another author's profile."
        redirect_to authors_url
        false
      end
    end
  
end
