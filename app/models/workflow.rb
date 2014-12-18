class Workflow < ActiveRecord::Base
  validates :name,presence: true
  belongs_to :project
  has_many :issues, -> { order("position ASC") }, dependent: :destroy

end
