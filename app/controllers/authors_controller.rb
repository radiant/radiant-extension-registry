class AuthorsController < ApplicationController
  before_filter :login_required, :only => [:edit, :update]
  before_filter :can_only_edit_self, :only => [:edit, :update]

  def index
    @authors = Author.find(:all).select{|a| a.extensions.size != 0}
    respond_to do |format|
      format.html
      format.xml { render :xml => @authors.to_xml }
    end
  end


  def show
    @author = Author.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @author.to_xml }
    end
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
      respond_to do |format|
        format.html do
          flash[:notice] = "Profile updated."
          redirect_to author_path(@author)
        end
        format.xml { head :accepted }
      end
    else
      respond_to do |format|
        format.html do
          flash[:notice] = "There were errors saving the form."
          render :action => "edit", :status => :unprocessible_entity
        end
        format.xml { render :xml => @author.errors.to_xml, :status => :unprocessible_entity }
      end
    end
  end

  protected

  def can_only_edit_self
    unless logged_in? && current_author.id.to_i == params[:id].to_i
      flash[:warning] = "You cannot edit another author's profile."
      respond_to do |format|
        format.html { redirect_to authors_url }
        format.xml { head :forbidden }
      end
      false
    end
  end
end
