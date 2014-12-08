class Project < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_many :workflows, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :teams, :allow_destroy => true
end
