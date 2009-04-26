class ExtensionsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :can_only_edit_own_extensions, :only => [:edit, :update, :destroy]

  make_resourceful do
    actions :all
    publish :xml, :attributes => [:name, :repository_url, :download_url, :repository_type, :download_type, :install_type, :description,
      {:author => [:first_name, :last_name, :email]}]

    response_for(:index) do |format|
      format.html
      format.atom
    end

    before :create do
      current_object.author = current_author
    end

    response_for(:create) do |format|
      format.html do
        set_default_flash(:notice, "Create successful!")
        set_default_redirect object_path
      end
      format.js
      format.xml { head :created, :location => object_url(current_object)}
    end

    response_for(:create_fails) do |format|
      format.html do
        set_default_flash :error, "There was a problem!"
        render :action => :new, :status => 422
      end
      format.js
      format.xml { render :xml => current_object.errors.to_xml, :status => :unprocessible_entity }
    end

    response_for(:update) do |format|
      format.html do
        set_default_flash :notice, "Save successful!"
        set_default_redirect object_path
      end
      format.js
      format.xml { head :accepted }
    end

    response_for(:update_fails) do |format|
      format.html do
        set_default_flash :error, "There was a problem saving!"
        render :action => :edit, :status => 422
      end
      format.js
      format.xml { render :xml => current_object.errors.to_xml, :status => :unprocessible_entity }
    end

    response_for(:destroy) do |format|
      format.html do
        set_default_flash :notice, "Record deleted!"
        set_default_redirect objects_path
      end
      format.js
      format.xml { head :ok }
    end

    response_for(:destroy_fails) do |format|
      format.html do
        set_default_flash :error, "There was a problem deleting!"
        set_default_redirect :back, :status => :failure
      end
      format.js
      format.xml { head :failure }
    end

  end

  protected

  def can_only_edit_own_extensions
    unless current_author.extension_ids.map(&:to_i).include?(params[:id].to_i)
      respond_to do |format|
        format.html do
          flash[:warning] = "You can only edit your own extensions."
          redirect_to objects_url
        end
        format.xml { head :forbidden }
      end
      return false
    end
  end
end