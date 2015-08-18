class PivotalProject < ActivePivot::Project
  validates :pivotal_id, :name, presence: true
  include StoryDuration

  def self.with_id(project_ids)
    where(pivotal_id: project_ids)
  end

  def self.ordered_by_name
    order(:name)
  end

  def self.name_by_id(project_id)
    find_by_pivotal_id(project_id).name
  end

  def average_cycle_time
    PivotalStory.month_cycle_time(pivotal_id)
  end

  def cycle_time
    duration_in_words(average_cycle_time)
  end
end
