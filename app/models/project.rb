class Project < ApplicationRecord
  belongs_to :status, class_name: 'ProjectStatus', foreign_key: :project_statuses_id

  has_many :comments, as: :commentable
  has_many :audits, as: :auditable

  validates :name, presence: true

  after_create :audit_project_created
  after_update :audit_project_updated

  def audit_project_created
    Audit.create(
      auditable: self,
      action: 'create',
      raw_changes: self.previous_changes
    )
  end

  def audit_project_updated
    Audit.create(
      auditable: self,
      action: 'update',
      raw_changes: self.previous_changes
    )
  end
end
