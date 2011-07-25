class NewissuealertsController < ApplicationController
  unloadable
  before_filter :find_project, :authorize, :only => [:index, :new, :edit]
  def index
    render('projects/settings/_newissuealerts')
  end
  
  def new
    if @project == nil
      render_404
      return
    end
    @newissuealert = Newissuealert.new(:project_id => @project.id )
    if request.post?
      #@newissuealert.project_id = params[:newissuealert][:project_id]
      @newissuealert.enabled = params[:newissuealert][:enabled]
      @newissuealert.mail_addresses = params[:newissuealert][:mail_addresses]
      if @newissuealert.save
        flash[:notice] = l(:newissuealerts_creation_success)
      else
        flash.now[:error] = l(:newissuealerts_creation_failed)
      end
      redirect_to :controller => "projects", :action => 'settings', :id => @project.identifier, :tab => 'newissuealerts'
    end
  end

  def edit
    @newissuealert = Newissuealert.find(params[:id])
    if request.post?
      if params[:delete]
        if @newissuealert.destroy
          flash[:notice] = l(:newissuealerts_deletion_success)
        else
          flash.now[:error] = l(:newissuealerts_deletion_failed)
        end
      elsif params[:save]
        if @newissuealert.update_attributes(params[:newissuealert])
          flash[:notice] = l(:newissuealerts_save_success) 
        else
          flash.now[:error] = l(:newissuealerts_save_failed)
        end
      end
      redirect_to :controller => "projects", :action => 'settings', :id => @project.identifier, :tab => 'newissuealerts'
    end
  end


  private

  def find_project
    begin
      @project = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      render_404
      @project = nil
    rescue => e
      flash.now[:error] = e
      @project = nil
    end
  end
end
