class PivotalStory < ActivePivot::Story
  validates :pivotal_id, :project_id, presence: true

  def self.month_cycle_time(project_id)
    average_duration_seconds(accepted_last_month(project_id))
  end

  def duration
    DateRange.new(started_at, accepted_at).business_seconds
  end

  def duration_all_days
    DateRange.new(started_at, accepted_at).all_seconds
  end

  private

  def self.accepted_last_month(project_id)
    for_project(project_id).feature.started.accepted.last_month
  end

  def self.average_duration_seconds (stories)
    stories.length > 0 ? stories.to_a.sum(&:duration) / stories.length : 0
  end

  def self.feature
    where(story_type: 'feature')
  end

  def self.started
    where.not(started_at: nil)
  end

  def self.accepted
    where.not(accepted_at: nil)
  end

  def self.last_month
    where("accepted_at >= ?", 1.months.ago.beginning_of_day)
  end

  def self.for_project(project_id)
    where(project_id: project_id)
  end
end
