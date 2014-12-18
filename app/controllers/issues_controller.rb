class IssuesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :issue_params
  load_and_authorize_resource :project, :except => [:sort]
  load_resource :workflow ,:except => [:sort]
  load_resource :issue, :through => :workflow, :except => [:sort]
  respond_to :html, :js


  def new
    add_breadcrumb "Projects", user_projects_path(current_user)
    add_breadcrumb @project.name, project_path(@project)
    add_breadcrumb @workflow.name, project_workflow_path(@project, @workflow)
    add_breadcrumb "Issue"
    @users = User.joins(:teams).where("teams.project_id = ?", @project.id)
  end

  def create
    add_breadcrumb "Projects", user_projects_path(current_user)
    add_breadcrumb @project.name, project_path(@project)
    add_breadcrumb @workflow.name, project_workflow_path(@project, @workflow)
    add_breadcrumb "Issue"
    @issue.creator_id = current_user.id
    @issue.project = @project
    if @issue.save
      flash[:success] = "Issue is created successfully"
      redirect_to project_path(@project)
      #redirect_to user_project_workflow_path(current_user, @project, @workflow)
    else
      flash[:error] = "Issue is not created successfully"
      render :new
    end
  end

  def sort
    params["work_flows"].each do |work_flow_name, issue_positions|
      workflow_id = work_flow_name.scan(/\d+/).map(&:to_i)[0]
      Issue.transaction do
        issue_positions.values.each do |issue_id|
          issue = Issue.find(issue_id.to_i)
          issue.update_attributes!(workflow_id: workflow_id) unless workflow_id == issue.workflow_id
        end

        workflow = Workflow.find(workflow_id)

        workflow.issues.each do |issue|
          issue.position = issue_positions.index(issue.id.to_s).to_i
          issue.save!
        end
      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

protected
  def issue_params
  params.require(:issue).permit(:id, :creator_id, :description, :title, :state,:assigned_to, :completed_by, :started_on, :estimate, :issue_type,          :workflow_id ,:project_id) if params[:issue]
  end

end
