class Team < ActiveRecord::Base
  validates :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  belongs_to :user
  belongs_to :project
  after_create :check_for_email

protected
  def check_for_email
    user = User.find_by_email(email)
    if user
      update_attributes(user_id: user.id)
    else
      from = User.find(project.user_id).email
      InviteMailer.invite_team(from, email).deliver
    end
  end
end
