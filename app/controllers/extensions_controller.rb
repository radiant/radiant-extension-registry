class ExtensionsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :can_only_edit_own_extensions, :only => [:edit, :update, :destroy]
  
  # GET /extensions
  # GET /extensions.atom
  def index
    respond_to do |format|
      format.html { @extensions = Extension.paginate :page => params[:page], :order => 'name' }
      format.xml  { @extensions = Extension.find(:all, :order=>"updated_at DESC"); render :xml => @extensions }
      format.atom { @extensions = Extension.find(:all, :order=>"updated_at DESC") }
    end
  end
  
  # GET /extensions/1
  # GET /extensions/1.xml
  def show
    @extension = Extension.find(params[:id])  
    respond_to do |format|
      format.html
      format.xml { render :xml => @extension }
    end
  end
  
  # GET /extensions/new
  def new
    @extension = Extension.new
  end
  
  # GET /extensions/1/edit
  def edit
    @extension = Extension.find(params[:id])
  end
  
  # POST /extensions
  # POST /extensions.xml
  def create
    @extension = Extension.new(params[:extension])
    @extension.author = current_author
    respond_to do |format|
      if @extension.save
        format.html { flash[:notice] = 'Created successfully!'; redirect_to extension_url(@extension) }
        format.js
        format.xml  { head :created, :location => extension_url(@extension) }
      else
        format.html { flash[:error] = 'There was a problem!'; render :action => "new", :status => 422 }
        format.js
        format.xml  { render :xml => @extension.errors.to_xml, :status => :unprocessible_entity }
      end
    end
  end
  
  # PUT /extensions/1
  # PUT /extensions/1.xml
  def update
    @extension = Extension.find(params[:id])
    respond_to do |format|
      if @extension.update_attributes(params[:extension])
        format.html { flash[:notice] = 'Updated successfully!'; redirect_to extension_url(@extension) }
        format.js
        format.xml  { head :ok }
      else
        format.html { flash[:error] = 'There was a problem saving!'; render :action => "edit", :status => 422 }
        format.js
        format.xml  { render :xml => @extension.errors.to_xml, :status => :unprocessible_entity }
      end
    end
  end

  # DELETE /extensions/1
  # DELETE /extensions/1.xml
  def destroy
    @extension = Extension.find(params[:id])
    if @extension.destroy
      respond_to do |format|
        format.html { flash[:notice] = "Record deleted!"; redirect_to extensions_url }
        format.js
        format.xml  { head :ok }
      end
    else
      respond_to do |format|
        format.html { flash[:error] = "There was a problem deleting!"; redirect_to :back, :status => :failure }
        format.js
        format.xml  { head :failure }
      end
    end
  end
  
  protected
  
    def can_only_edit_own_extensions
      unless current_author.extension_ids.map(&:to_i).include?(params[:id].to_i)
        respond_to do |format|
          format.html do
            flash[:error] = "You can only edit your own extensions."
            redirect_to extensions_url
          end
          format.xml { head :forbidden }
        end
        return false
      end
    end
    
    def can_edit?(extension)
      !!(current_author && (current_author.id == extension.author_id))
    end
    helper_method :can_edit?
  
end