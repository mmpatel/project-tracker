class Issue < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :project
  belongs_to :user
  has_many :comments, dependent: :destroy
end
