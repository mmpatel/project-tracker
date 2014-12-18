class Project < ActiveRecord::Base
  validates :name,:description, presence: true
  has_many :teams, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_many :workflows, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :teams, :allow_destroy => true
  accepts_nested_attributes_for :workflows, :allow_destroy => true
  after_create :add_default_workflows

  def has_default_workflows?
    workflows.map(&:name).map(&:downcase).include?("closed" || "backlog")
  end

  def add_default_workflows
    Workflow.new(:name => "backlog" ,:project_id => self.id).save
    Workflow.new(:name => "closed" ,:project_id => self.id).save
  end

  def available_users
    binding.pry
    user_id = self.id;
    User.joins(:teams).where("teams.project_id = ? or users.id = ?", @project.id, user_id)
  end
end
