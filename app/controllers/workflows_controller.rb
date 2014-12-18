class WorkflowsController < ApplicationController
  load_and_authorize_resource :project
  load_resource :workflow, through: :project
  before_filter :authenticate_user!

  def show
    add_breadcrumb "Projects", user_projects_path(current_user)
    add_breadcrumb @project.name, project_path(@project)
    add_breadcrumb @workflow.name, project_workflow_path(@project, @workflow)
  end

end
