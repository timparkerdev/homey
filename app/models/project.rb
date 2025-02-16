class Project < ApplicationRecord
  belongs_to :status, class_name: 'ProjectStatus', foreign_key: :project_statuses_id

  has_many :comments, as: :commentable

  validates :name, presence: true
end
