class Workflow < ActiveRecord::Base
  belongs_to :project
  has_many :issues, dependent: :destroy
end
