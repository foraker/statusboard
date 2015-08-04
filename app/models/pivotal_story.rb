class PivotalStory < ActiveRecord::Base
  validates :project_id, :story_id, :started_at, :project_name, presence: true

  def self.accepted
    where.not(accepted_at: nil)
  end

  def self.for_project(project_id)
    where(project_id: project_id)
  end

  def self.average_duration_seconds
    all.to_a.sum(&:duration) / all.size
  end

  def duration
    (accepted_at - started_at).to_i
  end
end
