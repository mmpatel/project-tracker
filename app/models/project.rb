class Project < ActiveRecord::Base
  validates :name,:description, presence: true
  has_many :teams, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_many :workflows, -> { order("position ASC") }, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :teams, :allow_destroy => true, :reject_if => lambda { |a| a[:email].blank? }

  accepts_nested_attributes_for :workflows, :allow_destroy => true, :reject_if => lambda { |a| a[:name].blank? }

  after_create :add_default_workflows
  after_create :add_default_team

  def has_default_workflows?
    workflows.map(&:name).map(&:downcase).include?("closed") || workflows.map(&:name).map(&:downcase).include?("backlog")
  end

  def add_default_workflows
    Workflow.new(:name => "backlog" ,:project_id => self.id).save
    Workflow.new(:name => "closed" ,:project_id => self.id).save
  end

  def available_users
    user_id = self.id;
    User.joins(:teams).where("teams.project_id = ? or users.id = ?", @project.id, user_id)
  end

  def add_default_team
    self.teams.create(user_id: user_id, email: user.email, access_level: "owner")
  end
end
