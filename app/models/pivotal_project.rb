class PivotalProject < ActivePivot::Project
  validates :pivotal_id, :name, presence: true

  def average_cycle_time
    PivotalStory.month_cycle_time(pivotal_id)
  end
end
