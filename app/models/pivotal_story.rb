class PivotalStory < ActivePivot::Story
  validates :pivotal_id, :project_id, presence: true

  def self.month_cycle_time(project_id)
    average_duration_seconds(accepted_last_month(project_id))
  end

  def duration
    (accepted_at - started_at).to_i - weekends_time
  end

  def weekends_time
    weekends_count * 1.day.to_i
  end

  def weekends_count
    date_range.reject {|d| (1..5).include?(d.wday) }.length
  end

  def date_range
    (started_at.to_date..accepted_at.to_date)
  end

  def duration_all_days
    (accepted_at - started_at).to_i
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
