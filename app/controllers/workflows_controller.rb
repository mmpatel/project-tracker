class WorkflowsController < ApplicationController
  load_and_authorize_resource :project, :except => [:sort]
  load_resource :workflow, through: :project, :except => [:sort]
  before_filter :authenticate_user!

  def show
    add_breadcrumb "Projects", user_projects_path(current_user)
    add_breadcrumb @project.name, project_path(@project)
    add_breadcrumb @workflow.name, project_workflow_path(@project, @workflow)
  end

  def sort
    params['work_flows'].each_with_index do |workflow_id, index|
      workflow = Workflow.find(workflow_id)
      workflow.position = index + 1
      workflow.save
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

end
