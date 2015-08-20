class PivotalStory < ActivePivot::Story
  validates :pivotal_id, :project_id, presence: true

  def self.month_cycle_time(project_id)
    average_duration_seconds(accepted_last_month(project_id))
  end

  def self.in_progress
    started.current_state_unstarted.unaccepted.order(:started_at).limit(10)
  end

  def self.recently_accepted
    started.accepted.order_recent_accepted
  end

  def duration
    DateRange.new(started_at, accepted_at).business_seconds
  end

  def duration_all_days
    DateRange.new(started_at, accepted_at).all_seconds
  end

  def project_by_id
    PivotalProject.find_by_pivotal_id(project_id)
  end

  def project_name
    project_by_id.name
  end

  def story
    PivotalStory.find_by_pivotal_id(pivotal_id)
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

  def self.unaccepted
    where(accepted_at: nil)
  end

  def self.current_state_unstarted
    where.not(current_state: ['unscheduled', 'unstarted'])
  end

  def self.last_month
    where("accepted_at >= ?", 1.months.ago.beginning_of_day)
  end

  def self.for_project(project_id)
    where(project_id: project_id)
  end

  def self.order_recent_accepted
    order("#{table_name}.accepted_at desc")
  end
end
