class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :project_params, only: [:create]
  load_and_authorize_resource

    def index
      @projects = current_user.available_projects unless current_user.is_admin?
      add_breadcrumb "Projects"
      flash.now[:error]="You don't have privilage yet to create project" unless current_user.can_create_projects
    end

    def new
      add_breadcrumb "Projects", user_projects_path(current_user)
      add_breadcrumb "Add project",:new_project_path
      @project.teams.build
      @project.workflows.build
    end

    def create
      add_breadcrumb "Add project",:new_project_path
      @project.user_id = current_user.id
      if  @project.has_default_workflows?
        flash.now[:error] = "backlog and closed are already entered"
        render 'new'
      else
        @project.teams.build(user_id: current_user.id, email: current_user.email, access_level: "owner")
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

private

  def project_params
    params.require(:project).permit(:name, :description, teams_attributes: [:id, :access_level, :user_id,:project_id, :email],workflows_attributes:[:id,:name,:tag,:project_id])
  end

end
