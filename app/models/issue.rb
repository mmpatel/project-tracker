class Issue < ActiveRecord::Base
  validates :title,:description, presence: true
  belongs_to :workflow
  belongs_to :project
  belongs_to :user, :foreign_key => "creator_id"
  has_many :comments, :as => :commentable, dependent: :destroy
  acts_as_list scope: :workflow
  acts_as_commentable
end
