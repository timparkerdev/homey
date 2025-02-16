class ProjectHistory
  DISPLAYABLE_ATTRIBUTES = %w(name project_statuses_id)
  ATTRIBUTE_NAME_MAPPING = {
    name: 'Name',
    project_statuses_id: 'Status'
  }

  attr_reader :project
  attr_reader :comments
  attr_reader :audits

  def initialize(project, comments, audits)
    @project = project
    @comments = comments.to_a
    @audits = audits.to_a
  end

  def self.call(...)
    new(...).call
  end

  def call
    displayable_audits = filtered_audits.map { |audit| audit_to_hash(audit) }
    displayable_comments = comments.map { |comment| comment_to_hash(comment) }

    (displayable_audits + displayable_comments).sort_by { |k| k[:created_at] }
  end

  private

  def filtered_audits
    audits.filter do |audit|
      audit.raw_changes.keys.any? { |key| key.in? DISPLAYABLE_ATTRIBUTES }
    end
  end

  def comment_to_hash(comment)
    {
      type: 'comment',
      content: comment.content,
      created_at: comment.created_at
    }
  end

  def audit_to_hash(audit)
    {
      type: 'audit',
      content: audit_content(audit),
      created_at: audit.created_at
    }
  end

  def audit_content(audit)
    DISPLAYABLE_ATTRIBUTES.map do |attribute|
      next unless audit.raw_changes.key?(attribute)

      attribute_change_text = change_to_text(audit, attribute)

      return "Project was created" if audit.action == 'create'

      "#{ATTRIBUTE_NAME_MAPPING[attribute.to_sym]} was changed #{attribute_change_text}"
    end.compact.join(', ')
  end

  def change_to_text(audit, attribute)
    return "from #{ProjectStatus.find(audit.raw_changes[attribute][0]).name} to #{ProjectStatus.find(audit.raw_changes[attribute][1]).name}" if attribute == 'project_statuses_id'
    return "from #{audit.raw_changes[attribute][0]} to #{audit.raw_changes[attribute][1]}" if audit.raw_changes[attribute].is_a?(Array)
  end
end