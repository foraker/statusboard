class PivotalProject < ActivePivot::Project
  validates :pivotal_id, :name, presence: true

  def self.with_id(project_ids)
    where(pivotal_id: project_ids)
  end

  def self.ordered_by_name
    order(:name)
  end

  def average_cycle_time
    PivotalStory.month_cycle_time(pivotal_id)
  end
end
