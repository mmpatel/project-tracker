class User < ActiveRecord::Base
  has_many :projects, dependent: :destroy, :foreign_key => :creator_id
  has_many :teams, dependent: :destroy
  has_many :issues, dependent: :destroy, :foreign_key => :creator_id
  has_many :comments, dependent: :destroy, :foreign_key => :creator_id
  after_create :check_for_admin

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def is_admin?
    Rails.application.config.admins.include?(email.downcase)
  end

  def states
    {:active => "active", :pending => "pending"}
  end

  def is_blocked?
    blocked
  end

protected
  def check_for_admin
    if is_admin?
      @user=User.find_by_email(email.downcase)
      @user.update(admin: true, can_create_projects: true, blocked: false, state: states[:active])
    else
      @user=User.find_by_email(email.downcase)
      @user.update(blocked: true, state: states[:pending])
    end
  end

end
