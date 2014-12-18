module ProjectsHelper
  def backlog_workflow project
    project.workflows.find_by_name("backlog")
  end
  def closed_workflow project
    project.workflows.find_by_name("closed")
  end
end
