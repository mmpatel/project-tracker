class ProjectsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource
  before_filter :authenticate_user!

    def index
    end

    def new
      @project.teams.build
    end

    def create
      @project = Project.new(project_params)
      @project.save
      redirect_to root_path
    end

private

  def project_params
    params.require(:project).permit(:name,:description, teams_attributes: [:id, :access_level, :user_id,:project_id])
  end

end
