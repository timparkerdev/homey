class Project < ApplicationRecord
  belongs_to :status, class_name: 'ProjectStatus', foreign_key: :project_statuses_id

  has_many :comments, as: :commentable
  has_many :audits, as: :auditable

  validates :name, presence: true

  after_save :audit_project

  def audit_project
    Audit.create(
      auditable: self,
      action: self.id_changed? ? 'create' : 'update',
      raw_changes: self.previous_changes
    )
  end

end
