class Attachment < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  belongs_to :issue
end
