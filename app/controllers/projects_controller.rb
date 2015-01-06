class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :project_params, only: [:create]
  load_and_authorize_resource :user, except: [:show ,:updateuser]
  load_and_authorize_resource

    def index
      @projects = current_user.available_projects unless current_user.is_admin?
      add_breadcrumb "Projects"
    end

    def new
      add_breadcrumb "Projects", user_projects_path(current_user)
      add_breadcrumb "Add project", new_user_project_path(current_user)
    end

    def edit
      add_breadcrumb "Projects", user_projects_path(current_user)
      add_breadcrumb @project.name, project_path(@project)
      teams=Team.joins(:project).where("teams.project_id = ?", @project.id)
      workflows=Workflow.joins(:project).where("workflows.project_id = ?", @project.id)
    end

    def update
      if @project.update(project_params)
        redirect_to user_projects_path(current_user.id)
      else
        render 'edit'
      end
    end

    def updateuser
      params['users'].each do |issue_id, user_id|
        issue = Issue.find(issue_id.to_i)
        issue.update_attributes(assigned_to: user_id.to_i)
      end
      issue = Issue.find(params['users'].keys[0].to_i)
      @project = issue.workflow.project
    end

    def create
      add_breadcrumb "Add project",new_user_project_path(current_user)
      @project.user_id = current_user.id
      if  @project.has_default_workflows?
        flash.now[:error] = "backlog and closed are already entered"
        render 'new'
      else
        if @project.save
          redirect_to root_path
        else
          render 'new'
        end
      end
    end

    def show
      add_breadcrumb "Projects", user_projects_path(current_user)
      add_breadcrumb @project.name
    end

    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      redirect_to root_path
    end

private

  def project_params
    params.require(:project).permit(:name, :description, teams_attributes: [:id, :access_level, :user_id, :project_id, :email, :_destroy],workflows_attributes: [:id, :name, :tag, :project_id, :_destroy])

  end

end
