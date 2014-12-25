class Workflow < ActiveRecord::Base
  belongs_to :project
  acts_as_list scope: :project
  has_many :issues, -> { order("position ASC") }, dependent: :destroy
  before_save { |workflow| workflow.name = workflow.name.downcase }
end
