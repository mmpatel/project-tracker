class Issue < ActiveRecord::Base
  validates :title,:description ,:completed_by,
    :started_on, presence: true
  belongs_to :workflow
  belongs_to :project
  belongs_to :user, :foreign_key => "creator_id"
  has_many :comments, dependent: :destroy
  acts_as_list scope: :workflow
end
